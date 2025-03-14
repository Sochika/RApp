import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/model/auth.dart';
import 'package:radius/provider/attendancereportprovider.dart';
import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/provider/leaveprovider.dart';
import 'package:radius/provider/meetingprovider.dart';
import 'package:radius/provider/morescreenprovider.dart';
import 'package:radius/provider/payslipdetailprovider.dart';
import 'package:radius/provider/payslipprovider.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/provider/profileprovider.dart';
import 'package:radius/provider/settingsprovider.dart';
import 'package:radius/screen/auth/login_screen.dart';
import 'package:radius/screen/dashboard/dashboard_screen.dart';
import 'package:radius/screen/general/generalscreen.dart';
import 'package:radius/screen/profile/chatscreen.dart';
import 'package:radius/screen/profile/editprofilescreen.dart';
import 'package:radius/screen/profile/groupchatscreen.dart';
import 'package:radius/screen/profile/payslipdetailscreen.dart';
import 'package:radius/screen/profile/profilescreen.dart';
import 'package:radius/screen/profile/meetingdetailscreen.dart';
import 'package:radius/screen/splashscreen.dart';
import 'package:radius/utils/navigationservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize timezone database
  tz.initializeTimeZones();

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US',]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: false);
  FirebaseFirestore.instance.clearPersistence();
  // Step required to send ios push notification
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined or has not accepted permission');
  }

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'digital_hr_group',
            channelKey: 'digital_hr_channel',
            channelName: 'Radius notifications',
            channelDescription: 'Radius Alert',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'digital_hr_group', channelGroupName: 'HR group')
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((event) {
    FlutterRingtonePlayer().play(
      fromAsset: "assets/sound/beep.mp3",
    );
    try {
      InAppNotification.show(
        onTap: () {
          Get.to(GeneralScreen(), arguments: {
            "title": event.notification!.title!,
            "message": event.notification!.body!,
            "date": ""
          });
        },
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            iconColor: HexColor("#011754"),
            textColor: HexColor("#011754"),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Row(
              children: [
                Container(child: const Icon(Icons.notifications)),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    event.notification!.title!,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                event.notification!.body!,
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      print(e);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    if (message.data.containsKey("type")) {
      print(message.data.toString());
      if (message.data["type"] == "chat") {
        Get.to(const ChatScreen(), arguments: {
          "name": message.data["sender_name"],
          "avatar": message.data["sender_image"],
          "username": message.data["sender_username"],
        });
        return;
      }

      if (message.data["type"] == "group_chat") {
        Get.to(const GroupChatScreen(), arguments: {
          "projectName": "",
          "projectId": message.data["project_id"],
          "projectSlug": message.data["conversation_id"],
          "leader": [],
          "member": [],
        });
        return;
      }
      Get.to(GeneralScreen(), arguments: {
        "title": message.data["title"],
        "message": message.data["message"],
        "date": ""
      });
    }
  });

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(LocalizedApp(delegate, const MyApp()));
  configLoading();
}

Future<void> _messageHandler(RemoteMessage message) async {
  FlutterRingtonePlayer().play(
    fromAsset: "assets/sound/beep.mp3",
  );
  print(message.data.toString());
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    final storage = GetStorage();


    return OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Preferences(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => LeaveProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => PrefProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => AttendanceReportProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => DashboardProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => MoreScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => MeetingProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => PaySlipProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => PaySlipDetailProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => SettingsProvider(),
          ),
        ],
        child: Portal(
          child: InAppNotification(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // Dismiss the keyboard when tapping outside the TextField
                FocusScope.of(context).requestFocus();
              },
              child: LocalizationProvider(
                state: LocalizationProvider.of(context).state,
                child: GetMaterialApp(
                  navigatorKey: NavigationService.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    localizationDelegate
                  ],
                  supportedLocales: localizationDelegate.supportedLocales,
                  locale: Locale(storage.read("language") ?? "en"),
                  theme: ThemeData(
                      canvasColor: const Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'GoogleSans',
                      primarySwatch: Colors.blue,
                      elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "GoogleSans"))),
                      appBarTheme: const AppBarTheme(
                          actionsIconTheme: IconThemeData(color: Colors.white),
                          iconTheme: IconThemeData(color: Colors.white),
                          titleTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "GoogleSans"))),
                  initialRoute: '/',
                  routes: {
                    '/': (_) => const SplashScreen(),
                    LoginScreen.routeName: (_) => LoginScreen(),
                    DashboardScreen.routeName: (_) => const DashboardScreen(),
                    ProfileScreen.routeName: (_) => const ProfileScreen(),
                    EditProfileScreen.routeName: (_) => const EditProfileScreen(),
                    MeetingDetailScreen.routeName: (_) => const MeetingDetailScreen(),
                    PaySlipDetailScreen.routeName: (_) => PaySlipDetailScreen(),
                  },
                  builder: EasyLoading.init(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
