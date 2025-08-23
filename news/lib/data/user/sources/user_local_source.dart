import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/auth/usecases/auth_check.dart';
import '../../../service_locator.dart';
import '../models/user_req_params.dart';

abstract class UserLocalSource {
  Future<Either> getUserFromPrefs();
  Future<void> saveUserToPrefs();
}

class UserLocalSourceImpl extends UserLocalSource {
  @override
  Future<Either> getUserFromPrefs() async {
    final SharedPreferences prefs =  await SharedPreferences.getInstance();

    try{
      final user = prefs.getString('user');
      return Right(UserModel.fromJson(json.decode(user!)));
    }catch (e){
      return Left("User not found");
    }
  }

  @override
  Future<void> saveUserToPrefs() async {
    final either = await sl<AuthCheckUseCase>().call();
    either.fold(
          (failure) {
        print("[Error]: $failure");
      },
          (userEntity) async {
        final prefs = await SharedPreferences.getInstance();

        final userJson = jsonEncode({
          "email": userEntity.email,
          "username": userEntity.username,
          "phoneNumber": userEntity.phoneNumber,
          "fullName": userEntity.fullName,
          "image": userEntity.image,
          "country": userEntity.country,
          "preferredCategory": userEntity.preferredCategory,
          'following':userEntity.following
        });

        await prefs.setString('user', userJson);
        print("[Success]: User saved to SharedPreferences");
      },
    );
  }
}
