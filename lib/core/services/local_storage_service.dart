import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final String _activeMissionKey = 'ACTIVE_MISSION_ID';

  Future<bool> saveActiveMission(String requestId) async {
    final pref = await SharedPreferences.getInstance();

    return await pref.setString(_activeMissionKey, requestId);
  }

  Future<String?> getActiveMission() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getString(_activeMissionKey);
  }

  Future<bool> clearActiveMission() async {
    final pref = await SharedPreferences.getInstance();

    return await pref.remove(_activeMissionKey);
  }
}
