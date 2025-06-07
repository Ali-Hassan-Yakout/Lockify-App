import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lockify/database/shared_preferences.dart';
import 'package:lockify/features/app_manger/app_manager_cubit.dart';
import 'package:lockify/features/home/view/home_screen.dart';
import 'package:lockify/features/login/view/login_screen.dart';
import 'package:lockify/features/onboarding/app_onboarding.dart';
import 'package:lockify/generated/l10n.dart';
import 'package:lockify/utils/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDF1UjGtnbuCzoXnQes8UPyKkY_ZKAyPRU",
      appId: "1:544787702985:android:a6d7caea9744667e8fd918",
      messagingSenderId: "544787702985",
      projectId: "lockify-3907a",
      storageBucket: "lockify-3907a.firebasestorage.app",
    ),
  );
  await PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      child: BlocProvider(
        create: (context) => AppManagerCubit(),
        child: BlocBuilder<AppManagerCubit, AppManagerState>(
          buildWhen: (previous, current) =>
              current is ThemeChange || current is LanguageChange,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: Locale(
                PreferenceUtils.getString(
                  PrefKeys.language,
                  'en',
                ),
              ),
              supportedLocales: S.delegate.supportedLocales,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: homeScreen(),
              themeMode: PreferenceUtils.getBool(PrefKeys.theme)
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
            );
          },
        ),
      ),
    );
  }

  Widget homeScreen() {
    if (PreferenceUtils.getBool(PrefKeys.isLoggedIn)) {
      return const HomeScreen();
    } else {
      if (PreferenceUtils.getBool(PrefKeys.onBoarding)) {
        return const LoginScreen();
      } else {
        return const AppOnBoarding();
      }
    }
  }
}
