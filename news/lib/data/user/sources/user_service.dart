import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news/core/constant/api_url.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/presentation/splash/pages/splash.dart';

import '../../../service_locator.dart';
import '../models/user_req_params.dart';

abstract class UserService {
  Future<Either> isFirstTimeUser();

  Future<Either> setupUserProfile(UserModel user);
  Future<Either> updateUserProfile(UserModel user);

}

class UserServiceImpl extends UserService {
  @override
  Future<Either> isFirstTimeUser() async {
    try {
      var response = await sl<DioClient>().get(ApiUrl.isFirstTimeUser);
      return Right(response.data['isFirstTimeUser']as bool);
    } on DioException catch (e) {
      return Left(e.response!.data["message"]);
    }
  }

  @override
  Future<Either> setupUserProfile(UserModel user) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.setupUserProfile,
        data: user.toJson(),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> updateUserProfile(UserModel user) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.update,
        data: user.toJson(),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
