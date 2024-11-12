import 'package:radius/provider/leavecalendarprovider.dart';
import 'package:radius/widget/holiday/holidaycard.dart';
import 'package:radius/widget/holiday/holidaycardview.dart';
import 'package:radius/widget/leavecalendar/birthdaycard.dart';
import 'package:radius/widget/leavecalendar/leavelistcardview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BirthdayListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final employeeBirthdayList =
        context
            .watch<LeaveCalendarProvider>()
            .employeeBirthdayList;
    print(employeeBirthdayList.length);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: employeeBirthdayList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final birthday = employeeBirthdayList[index];
            return GestureDetector(
                onTap: () {},
                child: BirthdayCard(
                    id: birthday.id,
                    name: birthday.name,
                    image: birthday.avatar, post: birthday.role)
            );
          }),
    );
  }
}
