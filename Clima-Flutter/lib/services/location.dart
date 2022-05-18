import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longtitude;

  // Location(this.latitude, this.longtitude);

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = position.latitude;
      longtitude = position.longitude;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
