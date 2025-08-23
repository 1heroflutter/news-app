import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/auth/usecases/isLoggedIn.dart';
import 'package:news/presentation/splash/bloc/splash_state.dart';

import '../../../service_locator.dart';

  class SplashCubit extends Cubit<SplashState>{
    SplashCubit():super(DisplaySplash());
    Future<void> appStarted() async {
      await Future.delayed(Duration(seconds: 2));
      try {
        final isLoggedIn = await sl<IsLoggedInUseCase>().call();
        if (isLoggedIn) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        print("SplashCubit error: $e");
        emit(Unauthenticated());
      }
    }

  }