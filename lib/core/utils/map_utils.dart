import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    final String googleMapsUrl =
        "google.navigation:q=$latitude,$longitude&mode=d";

    final String appleMapsUrl =
        "https://maps.apple.com/?q=$latitude,$longitude";
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
      await launchUrl(Uri.parse(appleMapsUrl));
    } else {
      throw 'Could not launch map navigation application.';
    }
  }
}
