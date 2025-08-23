import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/core/configs/assets/app_images.dart';
import 'package:news/domain/auth/usecases/auth_check.dart';
import 'package:news/presentation/auth/pages/onboarding.dart';
import 'package:news/presentation/auth/pages/signin.dart';
import 'package:news/presentation/splash/bloc/splash_cubit.dart';
import 'package:news/presentation/splash/bloc/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/bloc/generic_data_cubit.dart';
import '../../../domain/news/usecase/get_trending.dart';
import '../../../domain/user/usecases/is_first_time.dart';
import '../../../service_locator.dart';
import '../../main/bloc/user_cubit.dart';
import '../../main/pages/main.dart';
import '../../setupUserProfile/pages/setup_user_profile.dart';


Future<void> setUser() async {

  final either = await sl<AuthCheckUseCase>().call();
  either.fold(
        (failure) {
      print("[Error]: $failure");
    },
        (userEntity) async {
      final prefs = await SharedPreferences.getInstance();

      final userJson = jsonEncode({
        "email": userEntity.email,
        "username": userEntity.username,
        "phoneNumber": userEntity.phoneNumber,
        "fullName": userEntity.fullName,
        "image": userEntity.image,
        "country": userEntity.country,
        "preferredCategory": userEntity.preferredCategory,
        'following':userEntity.following
      });

      await prefs.setString('user', userJson);
      print("[Success]: User saved to SharedPreferences");
    },
  );
}
Future<bool> checkOnboardingStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('hasCompletedOnboarding') ?? false;
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) async {
          if (state is Authenticated) {
            setUser();
            var isFirstTime = await sl<IsFirstTimeUseCase>().call();
            isFirstTime.fold((l){
              print(l);
            }, (r){
              print("[R check ]: ${r.toString()}");
              if(r.toString()=="true"){
                AppNavigator.pushAndRemove(context, SetupUserProfilePage());
              }else{
                AppNavigator.pushAndRemove(
                  context,
                  MultiBlocProvider(
                    providers: [
                      BlocProvider<UserCubit>(
                        create: (_) => UserCubit()..loadUserFromPrefs(),
                      ),
                      BlocProvider<GenericDataCubit>(
                        create: (_) => GenericDataCubit()..getData(sl<GetTrendingUseCase>()),
                      ),
                    ],
                    child: MainPage(),
                  ),
                );

              }
            });
          } else {
            if (await checkOnboardingStatus()) {
              AppNavigator.pushAndRemove(context, SignInPage());
            } else {
              AppNavigator.pushReplacement(context, OnboardingPage());
            }
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.splash),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff1A1B20).withOpacity(0), Color(0xff1A1B20)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
