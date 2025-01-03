import 'package:radius/provider/attendancereportprovider.dart';
import 'package:radius/widget/headerprofile.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:radius/widget/attendancescreen/attendancestatus.dart';
import 'package:radius/widget/attendancescreen/attendancetoggle.dart';
import 'package:radius/widget/attendancescreen/reportlistview.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<StatefulWidget> createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<AttendanceScreen> {
  var initial = true;

  @override
  Future<void> didChangeDependencies() async {
    if (initial) {
      final provider =
      Provider.of<AttendanceReportProvider>(context, listen: false);
      provider.getDate();
      loadAttendanceReport();
      initial = false;
    }
    super.didChangeDependencies();
  }

  Future<String> loadAttendanceReport() async {
    try {
      await Provider.of<AttendanceReportProvider>(context, listen: false)
          .getAttendanceReport();
      return 'loaded';
    } catch (e) {
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FocusDetector(
          onVisibilityGained: () {
            final provider =
            Provider.of<AttendanceReportProvider>(context, listen: false);
            provider.getDate();
          },
          child: SafeArea(
              child: RefreshIndicator(
            onRefresh: () {
              return loadAttendanceReport();
            },
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    HeaderProfile(),
                    AttendanceStatus(),
                    AttendanceToggle(),
                    ReportListView()
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
