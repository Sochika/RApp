import 'package:radius/provider/leavecalendarprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_english_calendar/nepali_english_calendar.dart';
import 'package:provider/provider.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveCalendarView extends StatefulWidget {
  const LeaveCalendarView({super.key});

  @override
  State<StatefulWidget> createState() => LeaveCalendarState();
}

class LeaveCalendarState extends State<LeaveCalendarView> {
  final _current = DateTime.now();
  var _selected = DateTime.now();
  final currentMonth = DateTime.now().month;
  final nextMonth = DateTime.now().month + 1;
  bool initial = true;

  @override
  void didChangeDependencies() {
    if(initial){
      final provider = Provider.of<LeaveCalendarProvider>(context, listen: false);
      provider.getIsAd();

      initial = false;
    }
  }

  void getLeaveByDate(DateTime value) async {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(value);
    await Provider.of<LeaveCalendarProvider>(context, listen: false)
        .getLeavesByDay(outputDate);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveCalendarProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Consumer(
        builder: (context, value, child) {
          return provider.isAd
              ? englishCalendar(provider)
              : nepaliCalendar(provider);
        },
      ),
    );
  }

  TableCalendar englishCalendar(provider) {
    return TableCalendar(
      daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          weekendStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      headerStyle: const HeaderStyle(
          titleTextStyle: TextStyle(color: Colors.white),
          formatButtonTextStyle: TextStyle(
            color: Colors.transparent,
          ),
          formatButtonDecoration: BoxDecoration(color: Colors.transparent),
          leftChevronIcon: Icon(
            Icons.arrow_left,
            color: Colors.white,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_right,
            color: Colors.white,
          )),
      calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.white),
          markerDecoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20)))),
      eventLoader: (day) {
        var inputDate = day;
        var outputFormat = DateFormat('yyyy-MM-dd');
        var outputDate = outputFormat.format(inputDate);
        if (provider.employeeLeaveList.containsKey(outputDate)) {
          return provider.employeeLeaveList[outputDate] ?? [];
        } else {
          return [];
        }
      },
      currentDay: _current,
      firstDay: DateTime.utc(_current.year, currentMonth, 01),
      lastDay:
          DateTime.utc(_current.add(const Duration(days: 60)).year, nextMonth, 30),
      focusedDay: _selected,
      selectedDayPredicate: (day) {
        return isSameDay(_selected, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selected = selectedDay;
          getLeaveByDate(_selected);
        });
      },
    );
  }

  Stack nepaliCalendar(LeaveCalendarProvider provider) {
    return Stack(
      children: [
        NepaliCalendar(
          initialCalendarMode: DatePickerMode.day,
          language: NepaliUtils(),
          monthYearPickerStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          //Color to left right button
          rightLeftButtonColor: Colors.blue,
          //Styles to Week Row
          weekHeaderStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          firstDate:
              NepaliDateTime(NepaliDateTime.now().year, NepaliDateTime.now().month),
          lastDate: NepaliDateTime(
              NepaliDateTime.now().year, NepaliDateTime.now().month,32),
          onDateChanged: (date) {
            setState(() {
              print(date);
              _selected = date.toDateTime();
              getLeaveByDate(_selected);
            });
          },
          dayBuilder: (dayToBuild) {
            var inputDate = dayToBuild.toDateTime();
            var outputFormat = DateFormat('yyyy-MM-dd');
            var outputDate = outputFormat.format(inputDate);
            if (provider.employeeLeaveList.containsKey(outputDate)) {
              return Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      NepaliUtils().language == Language.english
                          ? '${dayToBuild.day}'
                          : NepaliUnicode.convert('${dayToBuild.day}'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.red,
                      ))
                ],
              );
            }else {
              return Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      NepaliUtils().language == Language.english
                          ? '${dayToBuild.day}'
                          : NepaliUnicode.convert('${dayToBuild.day}'),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              );
            }
          },
          selectedDayDecoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          todayDecoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ), initialDate: _selected.toNepaliDateTime(),
        ),
        Container(
          height: 60,
          width: Get.size.width,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
