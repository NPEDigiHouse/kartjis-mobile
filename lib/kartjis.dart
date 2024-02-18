import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/cores/styles/button_style.dart';
import 'package:kartjis_mobile_app/cores/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/cores/styles/input_style.dart';
import 'package:kartjis_mobile_app/cores/styles/text_style.dart';
import 'package:kartjis_mobile_app/cores/utils/keys.dart';
import 'package:kartjis_mobile_app/cores/utils/routes.dart';
import 'package:kartjis_mobile_app/features/users/users.dart';
import 'package:kartjis_mobile_app/features/main_menu/src/presentation/main_screen.dart';

import 'features/auth/auth.dart';

class KartjisApp extends StatelessWidget {
  const KartjisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartjis',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: colorScheme,
        textTheme: textTheme,
        dividerColor: dividerColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        filledButtonTheme: filledButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        textButtonTheme: textButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorObservers: [routeObserver],
      home: LoginPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case loginRoute:
            return MaterialPageRoute(
              builder: (_) => LoginPage(),
              settings: settings,
            );
          case registerRoute:
            return MaterialPageRoute(
              builder: (_) => const RegisterPage(),
              settings: settings,
            );
          case forgotPasswordRoute:
            return MaterialPageRoute(
              builder: (_) => ForgotPasswordPage(),
              settings: settings,
            );
          case otpRoute:
            final phoneNumber = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => OTPPage(phoneNumber: phoneNumber),
              settings: settings,
            );
          case resetPasswordRoute:
            return MaterialPageRoute(
              builder: (_) => const ResetPasswordPage(),
              settings: settings,
            );
          case mainRoute:
            return MaterialPageRoute(
              builder: (_) => const MainScreen(),
              settings: settings,
            );
          case profileRoute:
            return MaterialPageRoute(
              builder: (_) => const ProfilePage(),
              settings: settings,
            );
          default:
            return null;
        }
      },
    );
  }
}
