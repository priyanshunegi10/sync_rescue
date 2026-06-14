import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:sync_rescue/core/errors/app_exception.dart';

class LocationServices {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // check GPS is on or not
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationException(
          'Location services are disabled. Please turn on GPS.',
        );
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationException(
          'Location permissions are permanently denied in settings.',
        );
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
    } on TimeoutException {
      throw LocationException(
        'Taking too long to fetch location. Please try again.',
      );
    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException('Failed to get location: $e');
    }
  }
}
