import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotification.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    initializePlatform();
  }

  initializePlatform() {
    var initSettingAndroid =
        AndroidInitializationSettings('app_notification_icon');

    var initSettingIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification receiveNotification = new ReceiveNotification(
              id: id, title: title, body: body, payload: payload);
          didReceiveLocalNotificationSubject.add(receiveNotification);
        });

    initSetting = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);
  }

  setOnNotificationReceiveMethod(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClickMethod(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfDay(int day, int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);

    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print('scheduledDate.weekday: ${scheduledDate.weekday}');
    return scheduledDate;
  }

  Future<void> showWeeklyAtDayAndTimeNotification(int id, int medicineId,
      String title, String body, int day, int hour, int minute) async {
    var androidChannel = AndroidNotificationDetails(
        'CHANNEL_ID $id', 'CHANNEL_NAME $id', 'CHANNEL_DESCRIPTION $id',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        icon: 'app_notification_icon');

    var iosChannel = IOSNotificationDetails();

    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);

    await deleteOneNotification(id);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, _nextInstanceOfDay(day, hour, minute), platformChannel,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: medicineId.toString());

    print('Notification is added: $id, $body, $day, $hour, $minute');
  }

  Future<void> deleteOneNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    getPendingNotifications();
  }

  Future<void> deleteAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    print('All notifications deleted');
  }

  Future<void> getPendingNotifications() async {
    List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    print('Remaining Notifications: ${pendingNotificationRequests.length}');
  }
}

LocalNotification localNotification = LocalNotification.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification({this.id, this.title, this.body, this.payload});
}
