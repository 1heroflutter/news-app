import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news/core/constant/api_url.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/data/auth/models/signup_req_params.dart';
import 'package:news/data/user/models/user_req_params.dart';

import '../../../service_locator.dart';

abstract class AuthApiService {
  Future<Either> signIn(SignInReqParams params);
  Future<Either> logout();
  Future<Either> signUp(SignUpReqParams params);

  Future<Either> signInWithGoogle(String idToken);

  Future<String?> signInWithGoogleGetIdToken();

  Future<Either> sendOtp(String email);

  Future<Either> verifyOtp(String otp, String email);

  Future<Either> resetPassword(String password, String email);
  Future<Either> authCheck();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signIn(SignInReqParams signinParams) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signIn,
        data: signinParams.toJson(),
      );
      return Right(response.data['user']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
  @override
  Future<Either> logout( ) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.logout,
      );
      return Right(response.data['user']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
  @override
  Future<Either> signUp(SignUpReqParams params) async {
    try {
      var returnedData = await sl<DioClient>().post(
        ApiUrl.signUp,
        data: params.toJson(),
      );
      return Right(returnedData.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signInWithGoogle(String idToken) async {
    try {
      var returnedData = await sl<DioClient>().post(
        ApiUrl.signInWithGoogle,
        data: {"token": idToken},
      );
      return Right(returnedData.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<String?> signInWithGoogleGetIdToken() async {
    final googleSignIn = GoogleSignIn(
      scopes: ['email'],
      clientId:
          '367697500532-hic63jl8rl3f6s99cd9pd3ra6dob6k08.apps.googleusercontent.com',
    );
    try {
      final account = await googleSignIn.signIn();
      if (account == null) return null;
      final auth = await account.authentication;
      if (auth.idToken != null) {
        print("[GoogleSignin]: idToken: ${auth.idToken}");
      }
      final idToken = auth.idToken;
      return idToken;
    } catch (e, stack) {
      print("Google SignIn Error: $e");
      print("Stack trace: $stack");
      return null;
    }
  }

  @override
  Future<Either> sendOtp(String email) async {
    try {
      var returnedData = await sl<DioClient>().post(
        ApiUrl.sendOtp,
        data: {'email': email},
      );
      return Right(returnedData.data['message']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> resetPassword(String password, String email) async {
    try {
      var returnedData = await sl<DioClient>().post(
        ApiUrl.resetPassword,
        data: {"email": email, "newPassword": password},
      );
      return Right(returnedData.data['message']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> verifyOtp(String otp, String email) async {
    try {
      var returnedData = await sl<DioClient>().post(
        ApiUrl.verifyOtp,
        data: {"email": email, "otp": otp},
      );
      return Right(returnedData.data['message']);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> authCheck() async {
    try {
      var returnedData = await sl<DioClient>().get(
        ApiUrl.authCheck,
      );
      return Right(UserModel.fromJson(returnedData.data['user']));
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
