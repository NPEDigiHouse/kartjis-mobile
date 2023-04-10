import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartjis_mobile_app/common/styles/color_scheme.dart';
import 'package:kartjis_mobile_app/common/styles/text_style.dart';
import 'package:kartjis_mobile_app/common/utils/keys.dart';
import 'package:kartjis_mobile_app/common/utils/routes.dart';
import 'package:kartjis_mobile_app/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Prevent landscape orientation
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

// Change status bar and navigation color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartjis',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
        colorScheme: colorScheme,
        textTheme: textTheme,
        dividerColor: dividerColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorObservers: [routeObserver],
      home: const HomePage(),
    );
  }
}
