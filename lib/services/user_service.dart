import 'package:matchyourpet_mobile_app/constants/storage_access_keys.dart';
import 'package:matchyourpet_mobile_app/services/storage_service.dart';

class UserService {

  StorageService storageService = StorageService();

  Future<void> logoutUser() async {
    await storageService.deleteSecureData(StorageAccessKeys.adopterId);
    await storageService.deleteSecureData(StorageAccessKeys.email);
    await storageService.deleteSecureData(StorageAccessKeys.filterParams);
    return await storageService.deleteSecureData(StorageAccessKeys.jwt);
  }

}