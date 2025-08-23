import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/auth.dart';

class VerifyOTPUseCase extends UseCase<Either, String>{
  @override
  Future<Either> call({ String? params, String? email}) async {
    return await sl<AuthRepository>().verifyOtp(params!,email! );
  }
}