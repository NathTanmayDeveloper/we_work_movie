import 'package:geolocator/geolocator.dart';

class CustomLocation {
  static Future<CustomLocationDetails> getLocation() async {
    final isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      final permission = await Geolocator.checkPermission();
      switch (permission) {
        case LocationPermission.denied ||
              LocationPermission.deniedForever ||
              LocationPermission.unableToDetermine:
          final permissionAfterAsking = await Geolocator.requestPermission();
          if (permissionAfterAsking == LocationPermission.always ||
              permissionAfterAsking == LocationPermission.whileInUse) {
            return await getLocationWhenPermitted();
          }
          return CustomLocationDetails(
              permissionState: CustomLocationPermissionState.permissionDenied);
        case LocationPermission.always || LocationPermission.whileInUse:
          return await getLocationWhenPermitted();
      }
    } else {
      return CustomLocationDetails(
          permissionState: CustomLocationPermissionState.serviceDisabled);
    }
  }

  static Future<CustomLocationDetails> getLocationWhenPermitted() async {
    final location = await Geolocator.getCurrentPosition();
    return CustomLocationDetails(
        permissionState: CustomLocationPermissionState.permissionAllowed,
        positionDetails: CustomLocationPositionDetails(
            latitude: location.latitude, longitude: location.longitude));
  }
}

enum CustomLocationPermissionState {
  serviceDisabled,
  permissionDenied,
  permissionAllowed,
}

class CustomLocationDetails {
  CustomLocationPermissionState permissionState;
  CustomLocationPositionDetails? positionDetails;

  CustomLocationDetails({required this.permissionState, this.positionDetails});
}

class CustomLocationPositionDetails {
  double latitude;
  double longitude;

  CustomLocationPositionDetails(
      {required this.latitude, required this.longitude});
}
