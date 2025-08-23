import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/domain/auth/usecases/sendOTP.dart';
import 'package:news/presentation/auth/pages/otpVerification.dart';
import 'package:news/common/widgets/appbar/basicBtn.dart';

import '../../../core/configs/theme/app_theme.dart';
import '../../../service_locator.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  int currtentPage = 0;
  int chooseMethod = 1;
  final TextEditingController controller = TextEditingController();
  final List<String> text = [
    'Don’t worry! it happens. Please select the email or number associated with your account.',
    "Don’t worry! it happens. Please enter the address associated with your account.",
  ];
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                currtentPage == 0
                    ? AppNavigator.pop(context)
                    : setState(() {
                      currtentPage = 0;
                    });
              },
              icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
            ),
            Text(
              "Forgot \nPassword?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 46,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              text[currtentPage == 0 ? 0 : 1],
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: PageView.builder(
                itemCount: 2,
                onPageChanged:
                    (value) => setState(() {
                      currtentPage = value;
                    }),
                itemBuilder: (context, index) {
                  if (currtentPage == 0) {
                    return Column(
                      children: [
                        continueWith(
                          context,
                          "vid Email:",
                          "example@youremail.com",
                          Icons.email_outlined,
                          theme,
                          1,
                        ),
                        SizedBox(height: 20),
                        continueWith(
                          context,
                          "vid SMS:",
                          "+84 123 456 789",
                          Icons.sms_outlined,
                          theme,
                          2,
                        ),
                      ],
                    );
                  } else {
                    return emailField(controller, theme);
                  }
                },
              ),
            ),
            BasicBtn(onTap: () async {
              if (currtentPage == 0) {
                setState(() {
                  currtentPage = 1;
                });
              } else {
                //implement otpsend uc
                var response = await sl<SendOTPUseCase>().call(
                  params: controller.text,
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

                    Future.delayed(Duration(milliseconds: 500), () {
                      AppNavigator.push(context, OtpVerificationAndResetPasswordPage(email: controller.text,));
                    });
                  },
                );
              }
            }, theme: theme, text: "Submit",),
          ],
        ),
      ),
    );
  }

  Widget emailField(TextEditingController controller, ThemeData theme) {
    return TextField(
      style: TextStyle(color: theme.colorScheme.onPrimary),
      controller: controller,
      decoration: InputDecoration(hintText: "Enter your Email"),
    );
  }

  Widget continueWith(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    ThemeData theme,
    int radioValue,
  ) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Color(0xffEEF1F4),
      ),
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: theme.primaryColor,
                  ),
                  padding: EdgeInsets.all(20),
                  child: Icon(icon, size: 20),
                ),
                SizedBox(width: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Radio<int>(
            activeColor: theme.primaryColor,
            value: radioValue,
            groupValue: chooseMethod,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  chooseMethod = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }


}
