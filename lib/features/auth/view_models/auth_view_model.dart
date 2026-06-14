import 'package:flutter/foundation.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';
import 'package:sync_rescue/features/auth/models/user_model.dart';
import 'package:sync_rescue/features/auth/services/firebase_auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthServices _authServices = FirebaseAuthServices();

  UserModel? _currentUser;
  bool _isLoading = false;
  String _errorMessage = "";

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<bool> signUp(
    String email,
    String password,
    String name,
    String phoneNo,
  ) async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      UserModel? returnedUser = await _authServices.signUpWithEmail(
        email,
        password,
        name,
        phoneNo,
      );

      if (returnedUser != null) {
        _currentUser = returnedUser;
        return true;
      } else {
        _errorMessage = "Something went wrong. User is null.";
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      UserModel? returndUser = await _authServices.loginWithEmail(
        email,
        password,
      );

      if (returndUser != null) {
        _currentUser = returndUser;
        return true;
      } else {
        _errorMessage = "Something went wrong. user is null";
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      await _authServices.logout();
      _currentUser = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
