class SosRequestModel {
  String requestId;
  String victimId;
  String? volunteerId;
  double longitude;
  double latitude;
  String emergencyType;
  String status;
  DateTime? timestamp;

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
      'Latitude': latitude,
      'emergencyType': emergencyType,
      'status': status,
      'timestamp': timestamp?.toIso8601String(),
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
          ? DateTime.tryParse(map['timestamp'])
          : null,
    );
  }
}
