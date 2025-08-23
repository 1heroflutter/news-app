
import 'package:dartz/dartz.dart';
import 'package:news/data/user/models/user_req_params.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/user.dart';

class SetupUserProfileUseCase extends UseCase<Either, UserModel>{
  @override
  Future<Either> call({ UserModel? params}) async {
    return await sl<UserRepository>().setupUserProfile(params!);
  }
}