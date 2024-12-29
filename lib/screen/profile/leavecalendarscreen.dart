import 'package:radius/provider/leavecalendarprovider.dart';
import 'package:radius/widget/leavecalendar/BirthdayListview.dart';
import 'package:radius/widget/leavecalendar/HolidayListview.dart';
import 'package:radius/widget/leavecalendar/LeaveCalendarView.dart';
import 'package:radius/widget/leavecalendar/LeaveListview.dart';
import 'package:radius/widget/profile/calendartoggle.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveCalendarScreen extends StatelessWidget {
  const LeaveCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveCalendarProvider(),
      child: const LeaveCalendar(),
    );
  }
}

class LeaveCalendar extends StatefulWidget {
  const LeaveCalendar({super.key});

  @override
  State<StatefulWidget> createState() => LeaveCalendarState();
}

class LeaveCalendarState extends State<LeaveCalendar> {
  var initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      getLeaves();
      getLeaveByDate();
      initial = false;
    }
    super.didChangeDependencies();
  }

  void getLeaves() async {
    await Provider.of<LeaveCalendarProvider>(context).getLeaves();
  }

  void getLeaveByDate() async {
    var inputDate = DateTime.now();
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);
    await Provider.of<LeaveCalendarProvider>(context)
        .getLeavesByDay(outputDate);
  }

  @override
  Widget build(BuildContext context) {
    final toggle = context.watch<LeaveCalendarProvider>().toggleValue;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(translate('leave_calendar_screen.leave_calendar'),
              style: const TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Tooltip(
                  textStyle: TextStyle(color: Colors.black),
                  decoration: BoxDecoration(color: Colors.white),
                  message: "⏱️ -> Time Leave ",
                  child: Icon(Icons.info)),
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LeaveCalendarView(),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: const CalendarToggle()),
              toggle == 0 ? const LeaveListView() : const SizedBox.shrink(),
              toggle == 1 ? const HolidayListView() : const SizedBox.shrink(),
              toggle == 2 ? const BirthdayListView() : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
