import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/auth.dart';

class SendOTPUseCase extends UseCase<Either, String>{
  @override
  Future<Either> call({ String? params}) async {
    return await sl<AuthRepository>().sendOtp(params! );
  }
}