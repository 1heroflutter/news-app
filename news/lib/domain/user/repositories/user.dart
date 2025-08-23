import 'package:dartz/dartz.dart';
import 'package:news/data/user/models/user_req_params.dart';

abstract class UserRepository{
  Future<Either> isFirstTimeUser();
  Future<Either> setupUserProfile(UserModel user);
  Future<Either> updateUserProfile(UserModel user);

}