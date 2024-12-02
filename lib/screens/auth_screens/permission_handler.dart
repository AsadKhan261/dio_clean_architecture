import 'package:geolocator/geolocator.dart';


Future<Position> determinePosition() async {

  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  bool serviceEnabled;
  LocationPermission permission;


  serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
  if (!serviceEnabled) {
    geolocatorPlatform.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await geolocatorPlatform.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.denied) {
      geolocatorPlatform.openAppSettings();
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    geolocatorPlatform.openAppSettings();
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await geolocatorPlatform.getCurrentPosition();
}