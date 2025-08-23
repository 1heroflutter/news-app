import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/auth/models/signup_req_params.dart';
import 'package:news/domain/auth/usecases/signup.dart';
import 'package:news/presentation/auth/pages/signin.dart';
import 'package:reactive_button/reactive_button.dart';

import '../../../common/bloc/generic_data_cubit.dart';
import '../../../common/helper/app_navigator.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../data/auth/sources/auth_api_service.dart';
import '../../../domain/auth/usecases/signinWithGoogle.dart';
import '../../../domain/news/usecase/get_trending.dart';
import '../../../domain/user/usecases/is_first_time.dart';
import '../../../service_locator.dart';
import '../../main/bloc/user_cubit.dart';
import '../../main/pages/main.dart';
import '../../setupUserProfile/pages/setup_user_profile.dart';
import '../../splash/pages/splash.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController passCtrl = TextEditingController();

  bool obscureText = true;

  bool isCheck = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello!', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 46,
              color: theme.primaryColor,
            ),),
            Text(
              'Signup to get Started',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 24,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 40),
            emailField(emailCtrl),
            SizedBox(height: 20),
            passwordField(passCtrl, obscureText, () {
              setState(() {
                obscureText = !obscureText;
              });
            }),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                remember(() {}, theme, isCheck, (value) {
                  setState(() {
                    isCheck = value ?? false;
                  });
                }),
              ],
            ),
            SizedBox(height: 12),
            signupBtn(),
            SizedBox(height: 22),
            Center(
              child: Text(
                'or continue with',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                continueWith(
                  "FaceBook",
                  theme,
                  Image.asset(AppVectors.facebook),
                    (){}
                ),
                continueWith("Google", theme, Image.asset(AppVectors.google),() async {
                  final api = sl<AuthApiService>();
                  final idToken = await api.signInWithGoogleGetIdToken();
                  if (idToken == null) {
                    print("Lỗi khi lấy idToken");
                    return;
                  }
                  final result = await sl<SignInWithGoogleUseCase>().call(
                    idToken: idToken,
                  );
                  result.fold((err) => print(" Lỗi backend: $err"), (data) {
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

                    print(" Thành công: $data");
                  });
                },),
              ],
            ),
            SizedBox(height: 10),
            signUp(theme),
          ],
        ),
      ),
    );
  }

  Widget emailField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: "Email"),
    );
  }

  Widget passwordField(TextEditingController controller,
      bool obscure,
      VoidCallback onPress,) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: Icon(obscure ? Icons.remove_red_eye : Icons.visibility_off),
        ),
      ),
    );
  }

  Widget remember(VoidCallback onPress,
      ThemeData theme,
      bool isCheck,
      ValueChanged<bool?> onChanged,) {
    return Row(
      children: [
        Checkbox(
          value: isCheck,
          onChanged: onChanged,
          activeColor: AppColors.primary,
          checkColor: Colors.white,
        ),
        Text(
          "Remember me",
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
      ],
    );
  }
  Widget signupBtn(){
    return SizedBox(
      width: double.infinity,
      child: ReactiveButton(
        onPressed: () async {
          return await sl<SignUpUseCase>().call(
            params: SignUpReqParams(
              email: emailCtrl.text,
              password: passCtrl.text,
            ),
            isRemember: isCheck,
          );
        },
        onSuccess: () async {
          setUser();
          context.read<UserCubit>().loadUserFromPrefs();
          var isFirstTime = await sl<IsFirstTimeUseCase>().call();
          isFirstTime.fold((l){
            print(l);
          }, (r){
            if (r == true) {
              AppNavigator.pushAndRemove(context, SetupUserProfilePage());
            } else {
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
        },
        onFailure: (String error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        },
        title: 'Sign Up',
      ),
    );
  }
  Widget continueWith(String text, ThemeData theme, Widget icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xffEEF1F4),
        ),
        child: SizedBox(
          width: 100,
          child: Row(
            children: [
              SizedBox(height: 24, child: icon),
              SizedBox(width: 4),
              Text(text, style: TextStyle(fontSize: 15, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account ? ',
          style: TextStyle(fontSize: 14, color: theme.colorScheme.onPrimary),
        ),
        TextButton(
          onPressed: () {
            AppNavigator.push(context, SignInPage());
          },
          child: Text("Login", style: TextStyle(color: AppColors.primary)),
        ),
      ],
    );
  }
}
