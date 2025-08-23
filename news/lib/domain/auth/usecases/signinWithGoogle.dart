import 'package:dartz/dartz.dart';
import 'package:news/core/usecase/usecase.dart';
import 'package:news/data/auth/models/signin_req_params.dart';
import 'package:news/domain/auth/repositories/auth.dart';

import '../../../service_locator.dart';

class SignInWithGoogleUseCase extends UseCase<Either, SignInReqParams>{
  @override
  Future<Either> call({SignInReqParams? params,String? idToken})  async {
    return await sl<AuthRepository>().signInWithGoogle(idToken! );
  }
}