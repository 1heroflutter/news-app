import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/presentation/splash/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/bloc/generic_data_cubit.dart';
import '../../../common/helper/mapper/user_mapper.dart';
import '../../../common/widgets/appbar/basicBtn.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/textfield/basicTextfield.dart';
import '../../../data/user/models/user_req_params.dart';
import '../../../domain/news/usecase/get_trending.dart';
import '../../../domain/user/usecases/setup_user_profile.dart';
import '../../../service_locator.dart';
import '../../main/bloc/user_cubit.dart';
import '../../main/pages/main.dart';

class BuildProfilePage extends StatefulWidget {
  const BuildProfilePage({
    super.key,
    required this.pageController,
    required this.selectedTopics,
    required this.country,
  });

  final PageController pageController;
  final List<String> selectedTopics;
  final TextEditingController country;

  @override
  State<BuildProfilePage> createState() => _BuildProfilePageState();
}

class _BuildProfilePageState extends State<BuildProfilePage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserFromPrefs(email);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BasicAppBar(
            icon: Icons.arrow_back,
            title: Text(
              "Fill your Profile",
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onLeadingTap: () {
              widget.pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            suffer: null,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, left: 14, right: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 180,
                        child: CircleAvatar(
                          backgroundColor: theme.colorScheme.onPrimary,
                          radius: 80,
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: MediaQuery.of(context).size.width / 2 - 180,
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColor,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt,size: 20,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  BasicTextField(label: "Username", controller: userName),
                  SizedBox(height: 18),
                  BasicTextField(label: "Full Name", controller: fullName),
                  SizedBox(height: 18),
                  BasicTextField(label: "Email Address", controller: email),
                  SizedBox(height: 18),
                  BasicTextField(
                    label: "Phone Number",
                    controller: phoneNumber,
                  ),
                  Spacer(),
                  BasicBtn(
                    onTap: () async {
                      print('[Country]: ${widget.country.text}');
                      for (var topic in widget.selectedTopics) {
                        print("Selected : ${topic}");
                      }

                      var response = await sl<SetupUserProfileUseCase>().call(
                        params: UserModel(
                          fullName: fullName.text,
                          following: [],
                          phoneNumber: phoneNumber.text,
                          username: userName.text,
                          email: email.text,
                          id: null,
                          image: null,
                          otp: null,
                          searchHistory: [],
                          v: null,
                          preferredCategory: widget.selectedTopics.toList(),
                          country: widget.country.text,
                          isFirstLogin: false,
                        ),
                      );
                      response.fold(
                        (l) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(l)));
                        },
                        (r) {
                          setUser();
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Profile update success")));
                          context.read<UserCubit>().loadUserFromPrefs();
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

                        },
                      );
                    },
                    theme: theme,
                    text: "Next",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> loadUserFromPrefs(TextEditingController emailController) async {
  final prefs = await SharedPreferences.getInstance();
  final userJson = prefs.getString('user');

  if (userJson != null) {
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    final userModel = UserModel.fromJson(userMap);
    final user = UserMapper.toEntity(userModel);

    emailController.text = user.email ?? '';
  } else {
    print("No user found in SharedPreferences");
  }
}