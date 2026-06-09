class UserModel {
  String uid;
  String name;
  String phoneNo;
  String? activeEmergencyId;
  double? lastLatitude;
  double? lastLongitude;
  DateTime? lastLocationTime;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNo,
    this.activeEmergencyId,
    this.lastLatitude,
    this.lastLocationTime,
    this.lastLongitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNo': phoneNo,
      'activeEmergencyId': activeEmergencyId,
      'lastLatitude': lastLatitude,
      'lastLongitude': lastLongitude,
      'lastLocationTime': lastLocationTime?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      phoneNo: json['phoneNo'],
      activeEmergencyId: json['activeEmergencyId'],
      lastLatitude: (json['lastLatitude'] ?? 0).toDouble(),
      lastLongitude: (json['lastLongitude'] ?? 0).toDouble(),
      lastLocationTime: json['lastLocationTime'] != null
          ? DateTime.parse(json['lastLocationTime'])
          : null,
    );
  }
}
