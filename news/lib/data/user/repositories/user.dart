import 'package:dartz/dartz.dart';
import 'package:news/data/user/models/user_req_params.dart';
import 'package:news/data/user/sources/user_service.dart';
import 'package:news/domain/user/repositories/user.dart';

import '../../../service_locator.dart';

class UserRepositoryImpl extends UserRepository{
  @override
  Future<Either> isFirstTimeUser() async {
    var response = await sl<UserService>().isFirstTimeUser();
    return response.fold((error){
      return Left(error);
    }, (result){
      return Right(result);
    });
  }

  @override
  Future<Either> setupUserProfile(UserModel user) async {
    var response = await sl<UserService>().setupUserProfile(user);
    return response.fold((error){
      return Left(error);
    }, (result){
      return Right(result);
    });
  }

  @override
  Future<Either> updateUserProfile(UserModel user) async {
    var response = await sl<UserService>().updateUserProfile(user);
    return response.fold((error){
      return Left(error);
    }, (result){
      return Right(result);
    });
  }
}