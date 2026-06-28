import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService instance = NotificationService._();
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  GlobalKey<NavigatorState>? navigatorKey;

  Future<void> initialize() async {
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    const androidChannel = AndroidNotificationChannel(
      'flash_note_reminders',
      '提醒通知',
      importance: Importance.max,
    );

    await _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidChannel);

    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  Future<void> scheduleReminder({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    final tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _plugin.zonedSchedule(
      notificationId,
      title,
      body,
      tzTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'flash_note_reminders',
          '提醒通知',
          channelDescription: '灵感提醒',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> cancelNotification(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  void _onNotificationTapped(NotificationResponse response) {
    final reminderId = response.payload;
    if (reminderId != null && navigatorKey?.currentState != null) {
      navigatorKey!.currentState!.pushNamed('/detail/$reminderId');
    }
  }
}
