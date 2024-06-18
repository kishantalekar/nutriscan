import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nutriscan/app.dart';
import 'package:nutriscan/data/auth/authentication_repository.dart';
import 'package:nutriscan/firebase_options.dart';
import 'package:nutriscan/utils/helpers/notification_helper.dart';

void main() async {
  // widgets bindings
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // local storage
  await GetStorage.init();

  await NotificationHelper.init();

  // native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();
  runApp(const App());
}
