import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/data/auth/models/signup_req_params.dart';
import 'package:news/domain/auth/repositories/auth.dart';

import '../../../service_locator.dart';

class SignUpUseCase extends UseCase<Either, SignUpReqParams>{
  @override
  Future<Either> call({ SignUpReqParams? params, bool? isRemember}) async {
    return await sl<AuthRepository>().signUp(params!, isRemember! );
  }
}