import 'package:intl/intl.dart';
import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/data/source/network/model/dashboard/Dashboardresponse.dart';
import 'package:radius/data/source/network/model/login/User.dart';
import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/screen/general/generalscreen.dart';
import 'package:radius/utils/constant.dart';
import 'package:radius/utils/locationstatus.dart';
import 'package:radius/widget/customalertdialog.dart';
import 'package:radius/widget/homescreen/checkattendance.dart';
import 'package:radius/widget/homescreen/myteam.dart';
import 'package:radius/widget/homescreen/overviewdashboard.dart';
import 'package:radius/widget/homescreen/recentAward.dart';
import 'package:radius/widget/homescreen/upcomingholiday.dart';
import 'package:radius/widget/homescreen/weeklyreportchart.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:radius/widget/headerprofile.dart';
import 'package:quick_actions/quick_actions.dart';

class HomeScreen extends StatefulWidget {
  PersistentTabController controller;

  HomeScreen(this.controller, {super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState(controller);
}

class HomeScreenState extends State<HomeScreen> {
  QuickActions quickActions = const QuickActions();
  bool isEnabled = true;
  bool isLoading = false;
  double? userLatitude;
  double? userLongitude;
  String? Beat;
  int? beatNo;

  PersistentTabController controller;

  HomeScreenState(this.controller);

  @override
  void initState() {
    locationStatus();
    checkNotificationState();
    loadDashboard();

    quickActions.initialize((type) async {
      if (type == "actionCheckIn") {
        await onCheckInShortCut();
      } else if (type == "actionCheckOut") {
        await onCheckOutShortCut();
      }
    });
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'actionCheckIn', localizedTitle: 'Check In', icon: 'check_in'),
      const ShortcutItem(
          type: 'actionCheckOut',
          localizedTitle: 'Check Out',
          icon: 'check_out'),
    ]);
    super.initState();
  }

  void checkNotificationState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.getInitialMessage $message");
      if (message == null) {
        return;
      }
      Get.to(GeneralScreen(), arguments: {
        "title": message.data["title"],
        "message": message.data["message"],
        "date": ""
      });
    });
  }

  void locationStatus() async {

    try {
      Preferences preferences = Preferences();
      final position = await LocationStatus()
          .determinePosition(await preferences.getWorkSpace());

      if (!mounted) {
        return;
      }
      final location =
          Provider.of<DashboardProvider>(context, listen: false).locationStatus;

      location.update('latitude', (value) => position.latitude);
      location.update('longitude', (value) => position.longitude);
    } catch (e) {
      print(e);
      showToast(e.toString());
    }
  }

  Future<void> onCheckInShortCut() async {
    Preferences pref = Preferences();
    if ((await pref.getToken()).isNotEmpty) {
      if ((await pref.getUserAuth())) {
        return;
      }
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      try {
        isLoading = true;
        setState(() {
          EasyLoading.show(
              status: translate('loader.requesting'), maskType: EasyLoadingMaskType.black);
        });
        var status = await provider.getCheckInStatus();
        if (status) {
          final response = await provider.checkInAttendance();
          isEnabled = true;
          if (!mounted) {
            return;
          }
          setState(() {
            EasyLoading.dismiss(animation: true);
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: CustomAlertDialog(response.message),
                );
              },
            );
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          EasyLoading.dismiss(animation: true);
          isLoading = false;
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: CustomAlertDialog(e.toString()),
              );
            },
          );
        });
      }
    } else {
      showToast("Please Login First");
    }
  }

  Future<void> onCheckOutShortCut() async {
    Preferences pref = Preferences();
    if ((await pref.getToken()).isNotEmpty) {
      if ((await pref.getUserAuth())) {
        return;
      }
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      try {
        isLoading = true;
        setState(() {
          EasyLoading.show(
              status: "Requesting...", maskType: EasyLoadingMaskType.black);
        });
        var status = await provider.getCheckInStatus();
        if (status) {
          final response = await provider.checkOutAttendance();
          isEnabled = true;
          if (!mounted) {
            return;
          }
          setState(() {
            EasyLoading.dismiss(animation: true);
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: CustomAlertDialog(response.message),
                );
              },
            );
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          EasyLoading.dismiss(animation: true);
          isLoading = false;
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: CustomAlertDialog(e.toString()),
              );
            },
          );
        });
      }
    } else {
      showToast("Please Login First");
    }
  }

  Future<Dashboardresponse> fetchDashboard() async {
    return await Provider.of<DashboardProvider>(context, listen: false).getDashboard();
  }

  Future<String> loadDashboard() async {
    // var fcm = await FirebaseMessaging.instance.getToken();
    // print(fcm);
    // print('jeloo1');

    try {
      // final dashboardResponse =fetchDashboard();
      // await Provider.of<DashboardProvider>(context, listen: false)
      //     .getDashboard();
      // print('jeloo2');
      final dashboardResponse = await fetchDashboard();
      // print('jeloo3 $dashboardResponse');

      final user = dashboardResponse.data.user;
      userLatitude = dashboardResponse.data.userAttend.beatBranch.latitude != null
          ? double.tryParse(dashboardResponse.data.userAttend.beatBranch.latitude)
          : null;

      userLongitude = dashboardResponse.data.userAttend.beatBranch.longitude != null
          ? double.tryParse(dashboardResponse.data.userAttend.beatBranch.longitude)
          : null;

      print("Latitude: $userLatitude, Longitude: $userLongitude");

      setState(() {
        this.userLatitude = userLatitude;
        this.userLongitude = userLongitude;
        this.Beat = dashboardResponse.data.userAttend.beatBranch.name;
        this.beatNo = dashboardResponse.data.shifts.length;
      });

      Provider.of<PrefProvider>(context, listen: false).saveBasicUser(User(
          id: user.userId,
          firstName: user.staff.firstName,
          lastName: user.staff.lastName,
          avatar: user.staff.avatar,
          gender: user.staff.gender,
          staffNo: user.staff.staff_no,
          hireDate: user.staff.hire_date,
          dob: user.staff.dob));

      // Provider.of<PrefProvider>(context, listen: false)
      //     .saveEngDateEnabled(dashboardResponse.data.dateInAd);

      if (checkIfBirthday(dashboardResponse.data.user.staff.dob)) {
        showBirthdayWish();
      }
      return 'loaded';
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  bool checkIfBirthday(String dob) {
    // try {
      // Parse the dob string into a DateTime object
    final DateTime dobDate = DateFormat('yyyy-MM-dd').parse(dob);

      // Get today's date
      final DateTime today = DateTime.now();

      // Check if the day and month match
      final bool isBirthday = (dobDate.day == today.day && dobDate.month == today.month);

      return isBirthday;

  }

  void showBirthdayWish() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/raw/hbd.json'),
                  Lottie.asset('assets/raw/hbd_text.json'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FocusDetector(
          onFocusGained: () {
            loadDashboard();
          },
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            edgeOffset: 50,
            onRefresh: () {
              return loadDashboard();
            },
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderProfile(),
                  CheckAttendance(latitude: userLatitude ?? 0.00, longitude: userLongitude ?? 0.00, Beat:  Beat ?? 'the designated area'),
                  OverviewDashboard(controller, beatNo ?? 0),
                  const UpcomingHoliday(),
                  const RecentAward(),
                  // const WeeklyReportChart(),
                  const MyTeam()
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
