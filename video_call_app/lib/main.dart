import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'video_call_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _handleIncomingCallNotification(message.data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'call_channel',
      channelName: 'Call Channel',
      channelDescription: 'Incoming call notifications',
      importance: NotificationImportance.Max,
      defaultRingtoneType: DefaultRingtoneType.Ringtone,
      locked: true,
      playSound: true,
      enableVibration: true,
    ),
  ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (ReceivedAction action) async {
      if (action.buttonKeyPressed == 'ACCEPT') {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder:
                (_) => VideoCallScreen(
                  channelName: action.payload?['channel_name'] ?? 'default',
                  callerName: action.payload?['caller_name'] ?? 'Caller',
                ),
          ),
        );
      }
    },
  );

  runApp(MyApp());
}

void _handleIncomingCallNotification(Map<String, dynamic> data) {
  if (data['type'] == 'incoming_call') {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'call_channel',
        title: '${data['caller_name']} is calling...',
        body: 'Tap to answer',
        category: NotificationCategory.Call,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        payload: {
          'channel_name': data['channel_name'],
          'caller_name': data['caller_name'],
        },
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'ACCEPT',
          label: 'Accept',
          color: Colors.green,
          autoDismissible: true,
        ),
        NotificationActionButton(
          key: 'DECLINE',
          label: 'Decline',
          color: Colors.red,
          autoDismissible: true,
        ),
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initFirebaseMessaging();
  }

  void initFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((token) {
      print('Firebase Token: $token');
    });
    FirebaseMessaging.onMessage.listen((message) {
      _handleIncomingCallNotification(message.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(title: Text('Call Notification App')),
        body: Center(child: Text('Waiting for call...')),
      ),
    );
  }
}
