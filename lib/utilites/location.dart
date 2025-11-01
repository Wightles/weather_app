import 'package:location/location.dart';

class LocationService {
  double? latitude;
  double? longitude;
  final Location _location = Location();

  Future<void> getCurrentLocation() async {
    try {
      // Проверяем включена ли служба геолокации
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          throw 'Location service is disabled';
        }
      }

      // Проверяем разрешения
      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw 'Location permission denied';
        }
      }

      // Получаем текущее местоположение
      LocationData locationData = await _location.getLocation().timeout(
        const Duration(seconds: 10),
      );

      if (locationData.latitude == null || locationData.longitude == null) {
        throw 'Invalid location data received';
      }

      latitude = locationData.latitude;
      longitude = locationData.longitude;
      
    } catch (e) {
      throw 'Failed to get location: $e';
    }
  }
}