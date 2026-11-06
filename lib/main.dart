import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constant/color_constants.dart';
import 'constant/text_constants.dart';
import 'presentation/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    const ProviderScope(
      child: FlowGuardApp(),
    ),
  );
}

class FlowGuardApp extends StatelessWidget {
  const FlowGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: TextConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.scaffoldBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.primaryBlue,
          primary: ColorConstants.primaryBlue,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
