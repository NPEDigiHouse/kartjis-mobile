import 'package:flutter/material.dart';
import 'package:kartjis_mobile_app/common/styles/button_style.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/styles/input_style.dart';
import 'package:kartjis_mobile_app/common/styles/text_style.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';
import 'package:kartjis_mobile_app/common/utils/routes.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/forgot_password_page.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/login_page.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/otp_page.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/register_page.dart';
import 'package:kartjis_mobile_app/presentation/features/auth/reset_password_page.dart';
import 'package:kartjis_mobile_app/presentation/main_screen.dart';

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
          default:
            return null;
        }
      },
    );
  }
}
