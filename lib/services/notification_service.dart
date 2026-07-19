import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart'
    as tz;
import 'package:timezone/timezone.dart'
    as tz;

class NotificationService {

  static final FlutterLocalNotificationsPlugin
      notificationsPlugin =
      FlutterLocalNotificationsPlugin();


  /// INITIALIZE
  static Future init() async {

    tz.initializeTimeZones();

    const AndroidInitializationSettings
        androidSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher');

    const InitializationSettings
        settings =
        InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin.initialize(
        settings);

    /// ANDROID 13+ PERMISSION
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }


  /// SCHEDULE NOTIFICATION
  static Future scheduleNotification({

    required int id,

    required String title,

    required String body,
  }) async {

    await notificationsPlugin.zonedSchedule(

      id,

      title,

      body,

      _nextInstanceOf9AM(),

      const NotificationDetails(

        android:
            AndroidNotificationDetails(

          'submission_channel',

          'Submission Notifications',

          importance:
              Importance.max,

          priority:
              Priority.high,
        ),
      ),

      androidScheduleMode:
          AndroidScheduleMode
              .exactAllowWhileIdle,

      uiLocalNotificationDateInterpretation:

          UILocalNotificationDateInterpretation
              .absoluteTime,

      matchDateTimeComponents:
          DateTimeComponents.time,
    );
  }


  /// NEXT 9 AM
  static tz.TZDateTime
      _nextInstanceOf9AM() {

    final tz.TZDateTime now =
        tz.TZDateTime.now(
            tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(

      tz.local,

      now.year,

      now.month,

      now.day,

      9,
    );

    if (scheduledDate.isBefore(now)) {

      scheduledDate =
          scheduledDate.add(
        const Duration(days: 1),
      );
    }

    return scheduledDate;
  }
}