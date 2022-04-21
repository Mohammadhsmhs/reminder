import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder/features/events/domain/usecases/create_event.dart';
import 'package:reminder/features/events/presentation/screens/appointment_screen.dart';
import 'package:reminder/features/events/presentation/widgets/timepicker/time_picker_custom.dart';
import 'package:reminder/features/login/presentation/screens/login_screen.dart';
import 'package:reminder/features/login/presentation/screens/splash_screen.dart';
import 'package:reminder/features/login/presentation/screens/verification_screen.dart';

import 'features/events/presentation/screens/create_event_screen.dart';
import 'features/login/presentation/GetX/login_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.put(LoginController());

    return GetMaterialApp(
      title: 'reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: _loginController.hasValidToken,
          builder: ((context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.data == true) {
                  return const AppointmentScreen();
                } else {
                  return const LoginScreen();
                }
              default:
                return const SplashScreen();
            }
          })),
      // ? const LoginScreen()
      // : const AppointmentScreen(),
      routes: {
        LoginScreen.route: ((context) => const LoginScreen()),
        VerificationScreen.route: ((context) => const VerificationScreen()),
      },
    );
  }
}
