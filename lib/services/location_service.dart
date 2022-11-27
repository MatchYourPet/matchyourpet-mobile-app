import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<bool> hasLocationPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isDenied) {
        Map<Permission, PermissionStatus> status = await [
        Permission.location
        ].request();
        return false;
      } else if (status.isPermanentlyDenied) {
        return false;
      }
    } else {
      return false;
    }
    return true;
  }
}