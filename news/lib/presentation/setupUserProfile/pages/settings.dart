import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/common/helper/app_navigator.dart';
import 'package:news/common/widgets/appbar/basic_appbar.dart';
import 'package:news/domain/auth/usecases/logout.dart';
import 'package:news/presentation/auth/pages/forgotPassword.dart';
import 'package:news/presentation/auth/pages/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/configs/theme/theme_provider.dart';
import '../../../service_locator.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          BasicAppBar(
            icon: Icons.arrow_back,
            title: const Text('Settings'),
            onLeadingTap: () => AppNavigator.pop(context),
            suffer: null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _settingBtn(
                  Icons.notifications_none_rounded,
                  "Notification",
                  theme,
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.navigate_next, size: 16),
                  ),
                  () {},
                ),
                _settingBtn(
                  Icons.lock_open_outlined,
                  "Security",
                  theme,
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.navigate_next, size: 16),
                  ),
                  () {},
                ),
                _settingBtn(
                  Icons.help_outline,
                  "Help",
                  theme,
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.navigate_next, size: 16),
                  ),
                  () {},
                ),
                _settingBtn(
                  Icons.password,
                  "Change Password",
                  theme,
                  null,
                  () {
                    AppNavigator.push(context, ForgotPasswordPage());
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Row(
                    children: [
                      const Icon(Icons.dark_mode_outlined, size: 22),
                      const SizedBox(width: 4),
                      Text(
                        "Dark Mode",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        activeColor: theme.primaryColor,
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          notifier.toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
                _settingBtn(Icons.logout, "Logout", theme, null, () async {
                  final result = await sl<LogoutUseCase>().call();
                  result.fold(
                    (error) {
                      // Xử lý khi lỗi
                      print("Logout failed: $error");
                    },
                    (success) async {
                      // Xử lý khi thành công
                      print("Logout success");
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear(); // xóa toàn bộ session local nếu cần
                      AppNavigator.pushAndRemove(
                        context,
                        SignInPage(),
                      ); // điều hướng về login
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingBtn(
    IconData icon,
    String content,
    ThemeData theme,
    IconButton? suffer,
    VoidCallback onPress,
  ) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        child: Row(
          children: [
            Icon(icon, size: 22),
            const SizedBox(width: 4),
            Text(
              content,
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            suffer ?? Container(),
          ],
        ),
      ),
    );
  }
}
