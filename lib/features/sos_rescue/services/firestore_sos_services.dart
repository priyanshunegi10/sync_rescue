import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';
import 'package:sync_rescue/features/sos_rescue/models/sos_request_model.dart';

class FirestoreSosServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // victum funtions

  // victum request bejega
  Future<void> sendSosRequest(SosRequestModel sosRequest) async {
    try {
      await _db
          .collection('sos_alerts')
          .doc(sosRequest.requestId)
          .set(sosRequest.toMap());
    } on FirebaseException catch (e) {
      throw DatabaseException(
        e.message ?? 'Firestore database failed to respond.',
      );
    } catch (e) {
      throw DatabaseException('Failed to process SOS request: $e');
    }
  }

  // location update hogi har 10-20 sec mei agar wo change hui tabhi
  Future<void> updateSosLocation(
    String requestId,
    double newLatitude,
    double newLongitude,
  ) async {
    try {
      await _db.collection('sos_alerts').doc(requestId).update({
        'latitude': newLatitude,
        'longitude': newLongitude,
      });
    } on FirebaseException catch (e) {
      throw DatabaseException(
        e.message ?? 'Firestore database failed to respond.',
      );
    } catch (e) {
      throw DatabaseException('Failed to update live location: $e');
    }
  }

  // status change hoga uska
  Future<void> updateSosStatus(String requestId, String newStatus) async {
    try {
      await _db.collection('sos_alerts').doc(requestId).update({
        'status': newStatus,
      });
    } on FirebaseException catch (e) {
      throw DatabaseException(
        e.message ?? 'Firestore database failed to respond.',
      );
    } catch (e) {
      throw DatabaseException('Failed to update new status: $e');
    }
  }

  // sari request display hogi
  Future<SosRequestModel?> getActiveSosRequest() async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) return null;

      final querySnapshot = await _db
          .collection('sos_alerts')
          .where('victimId', isEqualTo: currentUser.uid)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return SosRequestModel.fromMap(querySnapshot.docs.first.data());
      }

      return null;
    } on FirebaseException catch (e) {
      throw DatabaseException(
        e.message ?? 'Failed to read active SOS from Firestore.',
      );
    } catch (e) {
      throw DatabaseException('An unknown error occurred: $e');
    }
  }

  // Rescuer funtions

  //jitni bhi pending victums hei unhe dikha dega

  Future<List<SosRequestModel>> getPendingEmergencies() async {
    try {
      final querySnapshot = await _db
          .collection('sos_alerts')
          .where('status', isEqualTo: 'pending')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs
          .map((doc) => SosRequestModel.fromMap(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw DatabaseException(
        e.message ?? 'Failed to fetch pending emergencies.',
      );
    } catch (e) {
      throw DatabaseException(
        "An unknown error occurred while fetching emergencies: $e",
      );
    }
  }

  // req accept karenge
  Future<void> acceptSosRequest(String requestId) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw DatabaseException('User not authenticated. Cannot accept SOS.');
      }

      await _db.collection('sos_alerts').doc(requestId).update({
        'status': 'accepted',
        'volunteerId': currentUser.uid,
      });
    } on FirebaseException catch (e) {
      throw DatabaseException(
        e.message ?? 'Failed to accept pending emergencies.',
      );
    } catch (e) {
      throw DatabaseException(
        'An unknown error occurred while accepting SOS: $e',
      );
    }
  }

  // completeSosRequest

  Future<void> completeSosRequest(String requestId) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        throw DatabaseException('User not authenticated. Cannot accept SOS.');
      }

      await _db.collection('sos_alerts').doc(requestId).update({
        'status': 'resolved',
      });
    } on FirebaseException catch (e) {
      throw DatabaseException(e.message ?? '');
    } catch (e) {
      throw DatabaseException('An unknown error occurred');
    }
  }

  Stream<DocumentSnapshot> getRescueStatusStream(String requestId) {
    return _db.collection('sos_requests').doc(requestId).snapshots();
  }
}
