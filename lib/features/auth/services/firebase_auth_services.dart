import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';
import 'package:sync_rescue/features/auth/models/user_model.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Sign Up Function
  Future<UserModel?> signUpWithEmail(
    String email,
    String password,
    String name,
    String phoneNo,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          uid: user.uid,
          name: name,
          phoneNo: phoneNo,
        );

        await _db.collection("users").doc(user.uid).set(newUser.toMap());

        return newUser;
      } else {
        throw AuthException(
          "Firebase returned a null user without throwing an error ",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException("User not found");
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw AuthException("Email or password are wrong ");
      } else if (e.code == 'email-already-in-use') {
        throw AuthException("This email is already in use please go and login");
      }
      throw AuthException(e.message ?? 'Authentication failed');
    } catch (e) {
      throw AuthException('Database error: $e');
    }
  }

  // sign in / login funtion

  Future<UserModel?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // user fetch using uid
      if (user != null) {
        DocumentSnapshot doc = await _db
            .collection("users")
            .doc(user.uid)
            .get();
        // checking doc exist karta hei ya nhi
        if (doc.exists && doc.data() != null) {
          return UserModel.fromJson(doc.data() as Map<String, dynamic>);
        } else {
          throw AuthException(
            "Account found, but profile data is missing in database.",
          );
        }
      } else {
        throw AuthException("Firebase returned null user.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException("User not found");
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw AuthException("Email or password are wrong ");
      }
      throw AuthException(e.message ?? 'Authentication failed');
    } catch (e) {
      throw AuthException('Database error: $e');
    }
  }

  // signout / logout funtion

  Future<void> logout() async {
    await _auth.signOut();
  }
}
