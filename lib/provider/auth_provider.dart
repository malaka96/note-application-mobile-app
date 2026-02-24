import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:note_application_mobile_app/services/secure_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = SecureStorageService();
  bool isLoggedIn = false;

  Future<void> checkLoginStatus() async {
    final token = await _storage.getToken();
    isLoggedIn = token != null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await Dio().post(
        "http://10.0.2.2:8080/auth/mobile/login",
        data: {"email": email, "password": password},
      );
      final token = response.data["accessToken"];
      await _storage.deleteToken();
      await _storage.saveToken(token);
      isLoggedIn = true;
      notifyListeners();
    } on DioException{
      isLoggedIn = false;
      notifyListeners();
      rethrow;
    }
  }
}
