import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/domain/auth/usecases/resetPassword.dart';
import 'package:news/domain/auth/usecases/verifyOTP.dart';
import 'package:news/presentation/auth/pages/signin.dart';
import 'package:news/common/widgets/appbar/basicBtn.dart';
import 'package:news/presentation/auth/widgets/basicPasswordTextField.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../common/helper/app_navigator.dart';
import '../../../domain/auth/usecases/sendOTP.dart';
import '../../../service_locator.dart';

class OtpVerificationAndResetPasswordPage extends StatefulWidget {
  final String email;

  const OtpVerificationAndResetPasswordPage({super.key, required this.email});

  @override
  State<OtpVerificationAndResetPasswordPage> createState() =>
      _OtpVerificationAndResetPasswordPageState();
}

class _OtpVerificationAndResetPasswordPageState
    extends State<OtpVerificationAndResetPasswordPage> {
  int currentPage = 0;
  String otpCode = "";
  bool obscure = true;
  int _seconds = 60;
  Timer? _timer;
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final PageController _pageController = PageController();

  void _goToNextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() => currentPage = 1);
  }

  void _goToPrevPageOrExit() {
    currentPage == 0
        ? AppNavigator.pop(context)
        : setState(() => currentPage = 0);
  }

  void startTimer() {
    _seconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    },);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Back button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.onPrimary,
                ),
                onPressed: _goToPrevPageOrExit,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 15,
                ),
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) => setState(() => currentPage = index),
                  children: [_otpPage(theme), _resetPasswordPage(theme)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpPage(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "OTP Verification",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 34,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Enter the OTP sent to ${widget.email}',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 20),
        PinCodeTextField(
          appContext: context,
          length: 6,
          keyboardType: TextInputType.number,
          onChanged: (value) => otpCode = value,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(6),
            fieldHeight: 50,
            fieldWidth: 50,
            inactiveColor: theme.colorScheme.onPrimary,
            activeFillColor: theme.primaryColor,
            borderWidth: 1,
          ),
        ),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.05,),
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 16, color: theme.colorScheme.onPrimary),
            children: _seconds > 0
                ? [
              const TextSpan(text: "Resend codes in "),
              TextSpan(
                text: "$_seconds seconds",
                style: TextStyle(color: theme.primaryColor),
              ),
            ]
                : [
              const TextSpan(text: "You can resend codes"),
            ],
          ),
        ),
        if (_seconds == 0)
          TextButton(
            onPressed: () async {
              var response = await sl<SendOTPUseCase>().call(
                params: widget.email,
              );
              response.fold(
                    (error) {
                  print("🔥 Error received: $error");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error)));
                },
                    (message) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                },
              );
              startTimer();
            },
            child: Text("Resend Code", style: TextStyle(color:  theme.primaryColor),),
          ),
        Spacer(),
        BasicBtn(
          text: 'Verify',
          theme: theme,
          onTap: () async {
            final result = await sl<VerifyOTPUseCase>().call(
              params: otpCode,
              email: widget.email,
            );
            result.fold((error) => _showError(error), (message) {
              _showSuccess(message);
              _goToNextPage();
            });
          },
        ),
      ],
    );
  }

  Widget _resetPasswordPage(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reset\nPassword",
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        SizedBox(height: 20),
        BasicPasswordTextField(
          controller: newPassword,
          obscure: obscure,
          hint: "New Password",
          onPress: () => setState(() => obscure = !obscure),
        ),
        SizedBox(height: 14),
        BasicPasswordTextField(
          controller: confirmPassword,
          obscure: obscure,
          hint: "Confirm New Password",
          onPress: () => setState(() => obscure = !obscure),
        ),
        Spacer(),
        BasicBtn(
          text: 'Submit',
          theme: theme,
          onTap: () async {
            if (newPassword.text != confirmPassword.text) {
              _showError('Confirm password does not match');
              return;
            }

            final result = await sl<ResetPasswordUseCase>().call(
              params: confirmPassword.text,
              email: widget.email,
            );
            result.fold(
                  (error) => _showError(error),
                  (message) {
                _showSuccess(message);
                Future.delayed(Duration(seconds: 1), () {
                  AppNavigator.pushAndRemove(context, SignInPage());
                },);
              },
            );
          },
        ),
      ],
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
