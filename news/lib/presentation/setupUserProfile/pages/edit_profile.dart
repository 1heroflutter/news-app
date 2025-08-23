import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/helper/app_navigator.dart';

import '../../../common/widgets/appbar/basicBtn.dart';
import '../../../common/widgets/appbar/basic_appbar.dart';
import '../../../common/widgets/textfield/basicTextfield.dart';
import '../../main/bloc/user_cubit.dart';
import '../../main/bloc/user_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().loadUserFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoaded) {
          // Gán dữ liệu vào textfield
          final user = state.user;
          userName.text = user.username ?? '';
          fullName.text = user.fullName ?? '';
          email.text = user.email ?? '';
          phoneNumber.text = user.phoneNumber ?? '';
        }

        if (state is UserError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              BasicAppBar(
                icon: Icons.arrow_back,
                title: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onLeadingTap: () => AppNavigator.pop(context),
                suffer: [
                  IconButton(
                    onPressed: () {
                      if (state is UserLoaded) {
                        final updatedUser = state.user.copyWith(
                          username: userName.text,
                          fullName: fullName.text,
                          email: email.text,
                          phoneNumber: phoneNumber.text,
                        );

                        context.read<UserCubit>().updateUserProfile(
                          updatedUser,
                        );
                      }
                    },
                    icon: const Icon(Icons.check, size: 18),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 14,
                    right: 14,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 180,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Icon(Icons.account_circle, size: 170,),
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
                                icon: const Icon(Icons.camera_alt, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      BasicTextField(label: "Username", controller: userName),
                      const SizedBox(height: 18),
                      BasicTextField(label: "Full Name", controller: fullName),
                      const SizedBox(height: 18),
                      BasicTextField(label: "Email Address", controller: email),
                      const SizedBox(height: 18),
                      BasicTextField(
                        label: "Phone Number",
                        controller: phoneNumber,
                      ),
                    ],
                  ),
                ),
              ),
              if (state is UserLoading) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
