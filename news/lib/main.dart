import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news/core/configs/theme/app_theme.dart';
import 'package:news/core/configs/theme/theme_provider.dart';
import 'package:news/presentation/main/bloc/user_cubit.dart';
import 'package:news/presentation/splash/bloc/splash_cubit.dart';
import 'package:news/presentation/splash/pages/splash.dart';
import 'package:news/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()..appStarted()),
        BlocProvider(create: (_) => UserCubit()..loadUserFromPrefs()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:themeMode,
        home: SplashPage(),
      ),
    );
  }
}
