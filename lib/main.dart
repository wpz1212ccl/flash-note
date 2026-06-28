import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz_data.initializeTimeZones();
  final prefs = await SharedPreferences.getInstance();
  final locationStr = prefs.getString('tz_location') ?? 'Asia/Shanghai';
  tz.setLocalLocation(tz.getLocation(locationStr));

  await NotificationService.instance.initialize();
  NotificationService.instance.navigatorKey = NavigationService.navigatorKey;

  runApp(
    const ProviderScope(
      child: FlashNoteApp(),
    ),
  );
}
