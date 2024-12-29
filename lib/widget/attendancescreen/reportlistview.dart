import 'package:radius/provider/attendancereportprovider.dart';
import 'package:radius/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:radius/widget/attendancescreen/attendancecardview.dart';

class ReportListView extends StatelessWidget {
  const ReportListView({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceList =
        Provider.of<AttendanceReportProvider>(context).attendanceReport;
    final currentMonth =
        Provider.of<AttendanceReportProvider>(context).currentMonthReport;
    if (attendanceList.isNotEmpty) {
      return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                attendanceSummary(currentMonth),
                const SizedBox(height: 10,),
                attendanceReportTitle(),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: attendanceList.length,
                    itemBuilder: (ctx, i) {
                      return AttendanceCardView(
                        i,
                        attendanceList[i].attendance_date,
                        attendanceList[i].week_day,
                        attendanceList[i].check_in,
                        attendanceList[i].check_out,
                        attendanceList[i].worked_hours,
                      );
                    }),
              ],
            )),
      );
    } else {
      return Visibility(
        visible: Provider.of<AttendanceReportProvider>(context).isLoading
            ? true
            : false,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget attendanceSummary(Map<String, dynamic> currentMonth){
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            child: Container(
              color: Colors.white12,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    translate('attendance_screen.present_days'),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        currentMonth["present_days"],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            child: Container(
              color: Colors.white12,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    translate('attendance_screen.worked_hours'),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    currentMonth["worked_hour"],
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget attendanceReportTitle() {
    return Card(
      elevation: 0,
      color: Colors.black38,
      shape: ButtonBorder(),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            Expanded(
              flex: 1,
              child: Container(
                child: Text(translate('attendance_screen.date'),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.start),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(translate('attendance_screen.day'),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.start),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(translate('attendance_screen.start_time'),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(translate('attendance_screen.end_time'),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.right),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(translate('attendance_screen.worked_hours'),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.right),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
