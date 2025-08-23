import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/data/user/models/user_req_params.dart';
import 'package:news/domain/user/repositories/user.dart';

import '../../../service_locator.dart';

class UpdateUserProfileUseCase extends UseCase<Either,  UserModel>{
  @override
  Future<Either> call({UserModel? params}) async {
    return await sl<UserRepository>().updateUserProfile(params!);
  }
}