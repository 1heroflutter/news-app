import 'package:get_it/get_it.dart';
import 'package:news/core/network/dio_client.dart';
import 'package:news/data/auth/repositories/auth.dart';
import 'package:news/data/auth/sources/auth_api_service.dart';
import 'package:news/data/news/repositories/news.dart';
import 'package:news/data/news/sources/news_service.dart';
import 'package:news/data/user/repositories/user.dart';
import 'package:news/data/user/sources/user_service.dart';
import 'package:news/data/user_local_data_source/set_user.dart';
import 'package:news/domain/auth/repositories/auth.dart';
import 'package:news/domain/auth/usecases/auth_check.dart';
import 'package:news/domain/auth/usecases/isLoggedIn.dart';
import 'package:news/domain/auth/usecases/logout.dart';
import 'package:news/domain/auth/usecases/resetPassword.dart';
import 'package:news/domain/auth/usecases/sendOTP.dart';
import 'package:news/domain/auth/usecases/signin.dart';
import 'package:news/domain/auth/usecases/signinWithGoogle.dart';
import 'package:news/domain/auth/usecases/signup.dart';
import 'package:news/domain/auth/usecases/verifyOTP.dart';
import 'package:news/domain/news/repositories/news.dart';
import 'package:news/domain/news/usecase/get_by_category.dart';
import 'package:news/domain/news/usecase/get_by_source.dart';
import 'package:news/domain/news/usecase/get_everything.dart';
import 'package:news/domain/news/usecase/get_sources.dart';
import 'package:news/domain/news/usecase/get_trending.dart';
import 'package:news/domain/news/usecase/search.dart';
import 'package:news/domain/user/repositories/user.dart';
import 'package:news/domain/user/usecases/is_first_time.dart';
import 'package:news/domain/user/usecases/setup_user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/user/sources/user_local_source.dart';
import 'domain/user/usecases/get_user_from_local.dart';
import 'domain/user/usecases/update_user_profile.dart';

final sl = GetIt.instance;
void setUpServiceLocator(){
  sl.registerSingleton<DioClient>(DioClient());
  //service
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<UserService>(UserServiceImpl());
  sl.registerSingleton<UserLocalSource>(UserLocalSourceImpl());
  sl.registerSingleton<NewsService>(NewsServiceImpl());
  //repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<NewsRepository>(NewsRepositoryImpl());
  //usecase
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());
  sl.registerSingleton<SendOTPUseCase>(SendOTPUseCase());
  sl.registerSingleton<VerifyOTPUseCase>(VerifyOTPUseCase());
  sl.registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase());
  sl.registerSingleton<IsFirstTimeUseCase>(IsFirstTimeUseCase());
  sl.registerSingleton<AuthCheckUseCase>(AuthCheckUseCase());
  sl.registerSingleton<SetupUserProfileUseCase>(SetupUserProfileUseCase());
  sl.registerSingleton<GetUserFromPrefsUseCase>(GetUserFromPrefsUseCase());
  sl.registerSingleton<GetTrendingUseCase>(GetTrendingUseCase());
  sl.registerSingleton<GetEverythingUseCase>(GetEverythingUseCase());
  sl.registerSingleton<GetByCategoryUseCase>(GetByCategoryUseCase());
  sl.registerSingleton<GetBySourceUseCase>(GetBySourceUseCase());
  sl.registerSingleton<SearchUseCase>(SearchUseCase());
  sl.registerSingleton<GetSourcesUseCase>(GetSourcesUseCase());
  sl.registerSingleton<UpdateUserProfileUseCase>(UpdateUserProfileUseCase());
}