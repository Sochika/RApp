import 'package:radius/provider/notificationprovider.dart';
import 'package:radius/widget/notification/notificationlist.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: const Notification(),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  var initial = true;

  Future<String> getNotification() async {
    await Provider.of<NotificationProvider>(context, listen: false)
        .getNotification();

    return "Loaded";
  }

  @override
  void didChangeDependencies() {
    if (initial) {
      getNotification();
      initial = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(translate('notification_screen.notifications'),style: const TextStyle(color: Colors.white)),
          ),
          body: RefreshIndicator(
              onRefresh: () {
                Provider.of<NotificationProvider>(context, listen: false).page =
                    1;
                return getNotification();
              },
              child: const NotificationList())),
    );
  }
}
