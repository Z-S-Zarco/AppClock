import 'package:clock_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'enums.dart';
import 'menuinfo.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid = AndroidInitializationSettings('codex_logo');

  var initializationSettingsIOS = DarwinInitializationSettings(

  requestAlertPermission: true,

  requestBadgePermission: true,

  requestSoundPermission: true,

  onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});

  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {

  final String? payload = notificationResponse.payload;

  if (notificationResponse.payload != null) {

  debugPrint('notification payload: ' + notificationResponse.payload!);

  }

  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) =>
            MenuInfo(MenuType.clock, title: '', imageSource: ''),
        child: HomePage(),
      ),
    );
  }
}
