import 'package:flutter/material.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';
import 'package:sync_rescue/features/sos_rescue/models/sos_request_model.dart';
import 'package:sync_rescue/features/sos_rescue/services/firestore_sos_services.dart';

class RescuerViewModel extends ChangeNotifier {
  final FirestoreSosServices _db = FirestoreSosServices();

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
}
