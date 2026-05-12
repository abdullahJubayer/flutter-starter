import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'i_local_storage_service.dart';

@LazySingleton(as: ILocalStorageService)
@Named('secure')
class SecureStorageService implements ILocalStorageService {
  final FlutterSecureStorage secureStorage;

  SecureStorageService(this.secureStorage);

  @override
  Future<String?> getData(String key) async {
    try {
      return await secureStorage.read(key: key);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> setData(String key, String data) async {
    try {
      await secureStorage.write(key: key, value: data);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> remove(String key) async {
    try {
      await secureStorage.delete(key: key);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool?> clearAllData() async {
    try {
      await secureStorage.deleteAll();
      return true;
    } catch (_) {
      return false;
    }
  }
}



