import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveUserData(
      {required String key, required dynamic value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserData({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! delete user date 1 by 1 from SecureStorage

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // ! delete all data from SecureStore in one shot

  Future<void> deleteAllData() async {
    await _secureStorage.deleteAll();
  }

  // ! save and get userID
  Future<void> saveUserId({required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserID({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get User Name

  Future<void> saveUserName(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserName({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get User Email

  Future<void> saveUserEmail(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserEmailID({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get User Mobile

  Future<void> saveUserMobile(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserMobile({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get Category

  Future<void> saveCategory(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserCategory({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get Category Name

  Future<void> saveCategoryName(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getCategoryName({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get CompanyID

  Future<void> saveUserComanyId(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserCompanyID({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get BranchID

  Future<void> saveUserBranchId(
      {required String key, required String value}) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getUserBranchID({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get UserLoginToken

  Future<void> saveUserLoginToken(
      {required String key, required bool value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<String?> getUserLogInToken({required bool key}) async {
    return await _secureStorage.read(key: key.toString());
  }

  // ! save and get tima logo

  Future<void> saveTimaLogo({required String key, required bool value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<String?> getTimaLogo({required String key}) async {
    return await _secureStorage.read(key: key);
  }

  // ! save and get tima logo

  Future<void> saveUpdateLocation(
      {required String key, required bool value}) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  Future<String?> getUpdateLocation({required bool key}) async {
    return await _secureStorage.read(key: key.toString());
  }
}
