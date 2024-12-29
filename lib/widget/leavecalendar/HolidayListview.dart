import 'package:radius/provider/leavecalendarprovider.dart';
import 'package:radius/widget/holiday/holidaycard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HolidayListView extends StatelessWidget {
  const HolidayListView({super.key});

  @override
  Widget build(BuildContext context) {
    final holiday = Provider.of<LeaveCalendarProvider>(context).employeeHoliday;
    return holiday != null
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Holidaycard(
              id: holiday.id,
              name: holiday.title,
              month: DateFormat("MMM").format(holiday.dateTime),
              day: DateFormat("dd").format(holiday.dateTime),
              desc: holiday.description,
              isPublicHoliday: holiday.isPublicHoliday),
        )
        : const SizedBox.shrink();
  }
}
