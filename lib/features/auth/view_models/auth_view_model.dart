import 'package:flutter/foundation.dart';
import 'package:sync_rescue/features/auth/services/firebase_auth_services.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthServices _firebaseAuthServices = FirebaseAuthServices();
  
}
