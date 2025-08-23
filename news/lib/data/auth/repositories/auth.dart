import 'package:dartz/dartz.dart';
import 'package:news/common/helper/mapper/user_mapper.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/data/auth/models/signup_req_params.dart';
import 'package:news/data/auth/sources/auth_api_service.dart';
import 'package:news/domain/auth/repositories/auth.dart';
import 'package:news/domain/user/entities/user_req_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var token = sharedPreferences.get('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Either> signIn(SignInReqParams params, bool isRemember) async {
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    var response = await sl<AuthApiService>().signIn(params);
    return response.fold((error) {
      return Left(error);
    }, (data) {
      if (isRemember) {
        sharedPreferences.setString('token', data['token']);
      }
      return Right(data );
    });
  }
  @override
  Future<Either> logout() async {
    var response = await sl<AuthApiService>().logout();
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data );
    });
  }
  @override
  Future<Either> signUp(SignUpReqParams params, bool isRemember) async {
    var response = await sl<AuthApiService>().signUp(params);
    final SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    return response.fold((error) {
      return Left(error);
    }, (data) {
      sharedPreferences.setString('token', data['user']['token']);
      return Right(data );
    });
  }

  @override
  Future<Either> signInWithGoogle(String idToken) async {
    var response = await sl<AuthApiService>().signInWithGoogle(idToken);
    return response.fold((error){
      return Left(error);
    }, (data){
      return Right(data);
    });
  }

  @override
  Future<Either> resetPassword(String password, String email) async {
    var response =await sl<AuthApiService>().resetPassword(password, email);
    return response.fold((error){
      return Left(error);
    }, (message){
      return Right(message);
    });
  }

  @override
  Future<Either> verifyOtp(String otp, String email) async {
    var response =await sl<AuthApiService>().verifyOtp(otp, email);
    return response.fold((error){
      return Left(error);
    }, (message){
      return Right(message);
    });
  }

  @override
  Future<Either> sendOtp(String email) async {
    var response =await sl<AuthApiService>().sendOtp(email);
    return response.fold((error){
      return Left(error);
    }, (message){
      return Right(message);
    });
  }

  @override
  Future<Either> authCheck() async {
    var response = await sl<AuthApiService>().authCheck();
    return response.fold((error) {
      return Left(error);
    }, (data) {
      UserEntity user = UserMapper.toEntity(data);
      return Right(user);
    });
  }



}