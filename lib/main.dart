import 'package:flutter/material.dart';
import 'package:flutterfeatures/src/views/appointment/appointment_controller.dart';
import 'package:flutterfeatures/src/views/appointment/appointment_service.dart';
import 'package:flutterfeatures/src/views/login/login_controller.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/views/login/login_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  final loginController = LoginController(LoginService());

  await loginController.init();

  final appointmentController = AppointmentController(AppointmentService());

  await loginController.init();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
    settingsController: settingsController,
    loginController: loginController,
    appointmentController: appointmentController,
  ));
}
