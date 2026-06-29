import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';
import 'package:sync_rescue/core/services/local_storage_service.dart';
import 'package:sync_rescue/features/sos_rescue/models/sos_request_model.dart';
import 'package:sync_rescue/features/sos_rescue/services/firestore_sos_services.dart';

class RescuerViewModel extends ChangeNotifier {
  final FirestoreSosServices _db = FirestoreSosServices();
  final LocalStorageService _localStorage = LocalStorageService(); 

  StreamSubscription<DocumentSnapshot>? _activeMissionSubscription;
  String _errorMessage = "";
  bool _isLoading = false;

  List<SosRequestModel> _pendingEmergencies = [];
  SosRequestModel? _activeRescue;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<SosRequestModel> get fetchAllEmergencies => _pendingEmergencies;
  SosRequestModel? get activeRescue => _activeRescue;

  Future<bool> fetchPendingEmergencies() async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      final emergencies = await _db.getPendingEmergencies();

      _pendingEmergencies = emergencies;

      return true;
    } on DatabaseException catch (e) {
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

  Future<bool> acceptRequest(String requestId) async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();
      await _db.acceptSosRequest(requestId);
      _activeRescue = _pendingEmergencies.firstWhere(
        (req) => req.requestId == requestId,
      );
      _pendingEmergencies.removeWhere((req) => req.requestId == requestId);

      listenToActiveMission(requestId);
      await _localStorage.saveActiveMission(requestId);
      return true;
    } on DatabaseException catch (e) {
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

  Future<bool> completeSosRequest() async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      await _db.completeSosRequest(_activeRescue!.requestId);

      _activeRescue = null;
      await _localStorage.clearActiveMission();
      await fetchPendingEmergencies();

      return true;
    } on DatabaseException catch (e) {
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

  void listenToActiveMission(String requestId) {
    _activeMissionSubscription?.cancel();

    _activeMissionSubscription = _db.getRescueStatusStream(requestId).listen((
      snapshot,
    ) async {
      if (!snapshot.exists) {
        _activeRescue = null;
        await _localStorage.clearActiveMission();
        _activeMissionSubscription?.cancel();
        _errorMessage = "The victim has cancelled this SOS request.";
        fetchPendingEmergencies();
        notifyListeners();
        return;
      }

      final data = snapshot.data() as Map<String, dynamic>?;
      final status = data?['status'];

      if (status == 'cancelled' || status == 'resolved') {
        _activeRescue = null;
        await _localStorage.clearActiveMission();
        _activeMissionSubscription?.cancel();
        _errorMessage = status == 'cancelled'
            ? "The victim has cancelled this SOS request."
            : "Rescue confirmed by victim!";
        fetchPendingEmergencies();
        notifyListeners();
      }
    });
  }
}
