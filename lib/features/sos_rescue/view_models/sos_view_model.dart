import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';
import 'package:sync_rescue/features/sos_rescue/models/sos_request_model.dart';
import 'package:sync_rescue/features/sos_rescue/services/firestore_sos_services.dart';
import 'package:sync_rescue/features/sos_rescue/services/location_services.dart';
import 'package:uuid/uuid.dart';

class SosViewModel extends ChangeNotifier {
  final FirestoreSosServices _db = FirestoreSosServices();
  final LocationServices _locationServices = LocationServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<Position>? _locationSubscription;

  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  SosRequestModel? _currentSosRequest;
  SosRequestModel? get currentSosRequest => _currentSosRequest;

  Future<bool> triggerSos(String emergencyType) async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      final user = _auth.currentUser;

      if (user == null) {
        throw DatabaseException('User is not logged in.');
      }

      final position = await _locationServices.getCurrentLocation();

      final String requestId = const Uuid().v4();

      final requestModel = SosRequestModel(
        requestId: requestId,
        victimId: user.uid,
        longitude: position.longitude,
        latitude: position.latitude,
        emergencyType: emergencyType,
        status: 'pending',
      );

      await _db.sendSosRequest(requestModel);
      _startLiveTracking(requestId);
      return true;
    } on DatabaseException catch (e) {
      _errorMessage = e.message;
      return false;
    } on LocationException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = "An unexpected error occurred: $e";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startLiveTracking(String requestId) {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _locationSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) async {
            try {
              await _db.updateSosLocation(
                requestId,
                position.latitude,
                position.longitude,
              );
            } catch (e) {
              if (kDebugMode) {
                print("Live tracking update failed: $e");
              }
            }
          },
        );
  }

  void stopLiveTracking() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  Future<bool> cancelActiveSos(String requestId) async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      await _db.updateSosStatus(requestId, "cancelled");

      stopLiveTracking();
      return true;
    } on DatabaseException catch (e) {
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = "An unexpected error occurred while cancelling: $e";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> stateRecover() async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      final activeRequest = await _db.getActiveSosRequest();

      if (activeRequest == null) {
        return false;
      }

      _currentSosRequest = activeRequest;

      _startLiveTracking(activeRequest.requestId);
      return true;
    } on DatabaseException catch (e) {
      _errorMessage = e.message;
      return false;
    } on NetworkException catch (e) {
      // Agar tune NetworkException custom banaya hai toh ye theek hai
      _errorMessage = e.message;
      return false;
    } catch (e) {
      _errorMessage = "An unexpected error occurred: $e";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
