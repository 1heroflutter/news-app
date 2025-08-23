import 'package:dartz/dartz.dart';
import 'package:news/data/user/sources/user_local_source.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/user/models/user_req_params.dart';
import '../../../service_locator.dart';

class GetUserFromPrefsUseCase extends UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<UserLocalSource>().getUserFromPrefs();
  }
}
