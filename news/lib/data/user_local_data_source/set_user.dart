import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/auth/usecases/auth_check.dart';
import '../../domain/user/entities/user_req_params.dart';
import '../../service_locator.dart';
abstract class UserLocalDataSource {
  Future<void> cacheUser(UserEntity user);
}
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences prefs;

  UserLocalDataSourceImpl(this.prefs);

  @override
  Future<void> cacheUser(UserEntity user) async {
    final userJson = jsonEncode({
      "email": user.email,
      "username": user.username,
      "phoneNumber": user.phoneNumber,
      "fullName": user.fullName,
      "image": user.image,
      "country": user.country,
    });

    await prefs.setString('user', userJson);
    print("[Success]: User saved to SharedPreferences");
  }
}
