import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';

class NotificationSer {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future showNotificationWithoutSound(Position position) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        '1', 'location-bg',
        channelDescription: 'fetch location in background',
        playSound: false,
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics =
        const IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Location fetched',
      position.toString(),
      platformChannelSpecifics,
      payload: '',
    );
  }

  NotificationSer() {
    var initializationSettingsAndroid =
        const  AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const  IOSInitializationSettings();
    var initializationSettings =  InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
