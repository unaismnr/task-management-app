import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static init() {
    _notificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    tz.initializeTimeZones();
  }

  static scheduleNotification(
    String title,
    String body,
    DateTime dueTime,
  ) async {
    var iosDetails = const DarwinNotificationDetails();
    var androidDetails = const AndroidNotificationDetails(
      'important_notifications',
      'My Channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _notificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(dueTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
