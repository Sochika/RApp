import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmScreen extends StatefulWidget {
  final String timeIn;
  final String timeOut;

  const AlarmScreen({
    Key? key,
    required this.timeIn,
    required this.timeOut,
  }) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late tz.Location _localTimezone;
  bool _initialized = false;
  String _statusMessage = 'Initializing...';
  final List<int> _scheduledNotificationIds = [];
  bool _isScheduling = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermission();
      _initializeTimeZones();
    });
  }

  Future<void> _initializeTimeZones() async {
    try {
      await _executeHeavyTask(() {
        tz.initializeTimeZones();
        return FlutterTimezone.getLocalTimezone();
      }).then((timezoneName) async {
        _localTimezone = tz.getLocation(timezoneName as String);
        await _initializeNotifications();
        await _scheduleAlarms();
        if (mounted) setState(() => _initialized = true);
      });
    } catch (e) {
      _updateStatus('Error: ${e.toString()}');
    }
  }

  Future<T> _executeHeavyTask<T>(T Function() task) async {
    return await compute((message) => task(), null);
  }



  Future<void> _initializeNotifications() async {
    var status = await Permission.notification.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.notification.request();
    }

    if (status.isGranted) {
      const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);

      await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationClicked,
      );

      debugPrint('Notification Permission Granted');
    } else {
      _updateStatus("Notification permission denied. Enable it from settings.");
    }
  }


  void _onNotificationClicked(NotificationResponse response) {
    debugPrint("Notification clicked: ${response.payload}");
  }

  Future<void> _scheduleAlarms() async {
    if (_isScheduling) return;
    _isScheduling = true;

    try {
      await _cancelExistingNotifications();

      final now = tz.TZDateTime.now(_localTimezone);
      final start = _parseTime(widget.timeIn);
      final end = _parseTime(widget.timeOut);

      if (start.isAfter(end)) {
        _updateStatus('End time cannot be before start time');
        return;
      }

      final scheduledTimes = await _calculateAlarmTimes(now, start, end);
      _updateStatus('Scheduled alarms at: ${scheduledTimes.join(', ')}');
    } catch (e) {
      _updateStatus('Scheduling failed: ${e.toString()}');
    } finally {
      _isScheduling = false;
    }
  }

  Future<void> _checkPermission() async {
    if (await Permission.notification.isDenied) {
      _updateStatus("Notification permission denied. Please allow it in settings.");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Permission Required"),
          content: const Text(
            "Please allow notifications in app settings to receive shift reminders.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: const Text("Open Settings"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        ),
      );
    }
  }


  Future<List<String>> _calculateAlarmTimes(
      tz.TZDateTime now,
      tz.TZDateTime start,
      tz.TZDateTime end,
      ) async {
    final scheduledTimes = <String>[];
    tz.TZDateTime currentAlarm = _calculateFirstAlarm(now, start);

    while (currentAlarm.isBefore(end)) {
      await _scheduleNotification(currentAlarm);
      scheduledTimes.add(DateFormat.jm().format(currentAlarm));
      currentAlarm = currentAlarm.add(const Duration(hours: 2));

      // Yield to event loop to prevent UI blockage
      await Future.delayed(Duration.zero);
    }

    return scheduledTimes;
  }

  tz.TZDateTime _calculateFirstAlarm(tz.TZDateTime now, tz.TZDateTime start) {
    if (now.isAfter(start)) {
      final nextEvenHour = now.hour + (2 - (now.hour % 2));
      return tz.TZDateTime(
        _localTimezone,
        now.year,
        now.month,
        now.day,
        nextEvenHour,
      ).add(nextEvenHour > 23 ? const Duration(days: 1) : Duration.zero);
    }
    return start;
  }

  tz.TZDateTime _parseTime(String time) {
    final parsed = DateFormat('HH:mm').parse(time);
    final now = tz.TZDateTime.now(_localTimezone);
    return tz.TZDateTime(
      _localTimezone,
      now.year,
      now.month,
      now.day,
      parsed.hour,
      parsed.minute,
    );
  }

  Future<void> _scheduleNotification(tz.TZDateTime time) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'alarm_channel',
        'Alarm Notifications',
        channelDescription: 'Scheduled reminders for operative shifts',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('alarm_sound'),
        playSound: true,
      );

      await _notificationsPlugin.zonedSchedule(
        time.millisecondsSinceEpoch ~/ 1000,
        'Shift Reminder',
        'Reminder for ${DateFormat.jm().format(time)}',
        time,
        const NotificationDetails(android: androidDetails),
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      _scheduledNotificationIds.add(time.millisecondsSinceEpoch ~/ 1000);
    } catch (e) {
      debugPrint("Notification error: $e");
    }
  }

  Future<void> _cancelExistingNotifications() async {
    for (final id in _scheduledNotificationIds) {
      await _notificationsPlugin.cancel(id);
    }
    _scheduledNotificationIds.clear();
  }

  void _updateStatus(String message) {
    if (mounted) {
      setState(() => _statusMessage = message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.alarm, size: 50, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              'Shift Times: ${widget.timeIn} - ${widget.timeOut}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            _initialized
                ? Text(
              _statusMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _initialized && !_isScheduling ? _scheduleAlarms : null,
              child: const Text('Refresh Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}