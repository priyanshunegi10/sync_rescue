import 'package:cloud_firestore/cloud_firestore.dart';

class SosRequestModel {
  final String requestId;
  final String victimId;
  final String? volunteerId;
  final double longitude;
  final double latitude;
  final String emergencyType;
  final String status;
  final DateTime? timestamp;

  SosRequestModel({
    required this.requestId,
    required this.victimId,
    this.volunteerId,
    required this.longitude,
    required this.latitude,
    required this.emergencyType,
    required this.status,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'volunteerId': volunteerId,
      'victimId': victimId,
      'longitude': longitude,
      'latitude': latitude,
      'emergencyType': emergencyType,
      'status': status,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  factory SosRequestModel.fromMap(Map<String, dynamic> map) {
    return SosRequestModel(
      requestId: map['requestId'],
      victimId: map['victimId'],
      volunteerId: map['volunteerId'],
      longitude: (map['longitude'] ?? 0).toDouble(),
      latitude: (map['latitude'] ?? 0).toDouble(),
      emergencyType: map['emergencyType'],
      status: map['status'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
    );
  }
}
