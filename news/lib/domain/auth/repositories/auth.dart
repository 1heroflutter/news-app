import 'package:dartz/dartz.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/data/auth/models/signup_req_params.dart';

abstract class AuthRepository{
  Future<Either> signUp(SignUpReqParams params, bool isRemember);
  Future<Either> signIn(SignInReqParams params, bool isRemember);
  Future<Either> logout();
  Future<Either> signInWithGoogle(String idToken);
  Future<Either> sendOtp(String email);
  Future<Either> verifyOtp(String otp, String email);
  Future<Either> resetPassword(String password, String email);
  Future<bool> isLoggedIn();
  Future<Either> authCheck();
}