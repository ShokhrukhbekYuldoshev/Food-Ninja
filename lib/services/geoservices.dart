import 'package:geolocator/geolocator.dart';

// get current location, ask for permission if not granted
Future<Position> getCurrentLocation() async {
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  final LocationPermission permission =
      await geolocatorPlatform.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  } else if (permission == LocationPermission.denied) {
    final LocationPermission permission =
        await geolocatorPlatform.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  return await geolocatorPlatform.getCurrentPosition();
}
