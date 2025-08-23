import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/common/widgets/appbar/basic_appbar.dart';
import 'package:news/domain/user/entities/user_req_params.dart';
import 'package:news/presentation/main/bloc/user_cubit.dart';
import 'package:news/presentation/main/bloc/user_state.dart';
import 'package:news/presentation/setupUserProfile/pages/edit_profile.dart';
import 'package:news/presentation/setupUserProfile/pages/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is UserLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: [
                  BasicAppBar(
                    icon: null,
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    onLeadingTap: null,
                    suffer: [
                      IconButton(
                        onPressed: () {
                          AppNavigator.push(context, SettingsPage());
                        },
                        icon: Icon(
                          Icons.settings_outlined,
                          size: 22,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  _userDetail(theme, user),
                ],
              ),
            );
          }
          if (state is UserError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.redAccent[100]),
              ),
            );
          }
          return IconButton(
            onPressed: () {
              AppNavigator.push(context, SettingsPage());
            },
            icon: Icon(
              Icons.settings_outlined,
              size: 22,
              color: theme.colorScheme.onPrimary,
            ),
          );
          return const Center(child: Text("User information is null"));
        },
      ),
    );
  }

  Widget _userDetail(ThemeData theme, UserEntity user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Icon(
                Icons.account_circle_outlined,
                size: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "PhoneNumber:",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  (user.phoneNumber ?? "").isNotEmpty
                      ? user.phoneNumber!
                      : "NA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Country:",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  user.country ?? "NA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              (user.fullName ?? "").isNotEmpty ? user.fullName! : "NA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                AppNavigator.push(context, EditProfilePage());
              },
              icon: Icon(Icons.edit_outlined, color: theme.primaryColor),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.005),
        Text(
          user.email.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 14,
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
