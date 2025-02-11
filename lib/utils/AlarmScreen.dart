import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key, required this.TimeIn, required this.TimeOut})
      : super(key: key);
  final String TimeIn;
  final String TimeOut;

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late String _localTimezone;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeTimeZones();
  }

  Future<void> _initializeTimeZones() async {
    try {
      // Initialize timezone database
      tz.initializeTimeZones();

      // Get local timezone
      _localTimezone = await FlutterTimezone.getLocalTimezone();

      // Initialize notifications after timezones are ready
      await _initializeNotifications();

      // Schedule alarms
      _scheduleAlarms();

      setState(() => _initialized = true);
    } catch (e) {
      print("Timezone initialization failed: $e");
    }
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        debugPrint("Notification clicked");
      },
    );
  }

  void _scheduleAlarms() {
    try {
      final now = DateTime.now();
      DateTime start = _parseTime(widget.TimeIn);
      DateTime end = _parseTime(widget.TimeOut);

      if (end.isBefore(start)) end = end.add(const Duration(days: 1));
      if (start == end) end = end.add(const Duration(days: 1));

      if (now.isAfter(start) && now.isBefore(end)) {
        DateTime nextAlarm = _calculateNextAlarm(now);
        while (nextAlarm.isBefore(end)) {
          _scheduleNotification(nextAlarm);
          nextAlarm = nextAlarm.add(const Duration(hours: 2));
        }
      }
    } catch (e) {
      print("Alarm scheduling error: $e");
    }
  }

  DateTime _calculateNextAlarm(DateTime current) {
    DateTime next = DateTime(
      current.year,
      current.month,
      current.day,
      current.hour + (2 - (current.hour % 2)),
      0,
    );
    return next.isAfter(current) ? next : next.add(const Duration(hours: 2));
  }

  DateTime _parseTime(String time) {
    final parsed = DateFormat('HH:mm').parse(time);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, parsed.hour, parsed.minute);
  }

  Future<void> _scheduleNotification(DateTime time) async {
    try {
      final tzLocation = tz.getLocation(_localTimezone);
      final tzTime = tz.TZDateTime.from(time, tzLocation);

      const androidDetails = AndroidNotificationDetails(
        'alarm_channel',
        'Alarm Notifications',
        channelDescription: 'Scheduled alarm reminders',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('alarm_sound'),
        playSound: true,
      );

      await _notificationsPlugin.zonedSchedule(
        time.millisecondsSinceEpoch ~/ 1000,
        'Operative Reminder',
        'It\'s ${DateFormat.jm().format(time)} - Stay vigilant',
        tzTime,
        const NotificationDetails(android: androidDetails),
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      print("Notification scheduling failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _initialized
          ? Text(
        'Alarms scheduled between ${widget.TimeIn} and ${widget.TimeOut}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      )
          : const CircularProgressIndicator(),
    );
  }
}