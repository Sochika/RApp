import 'package:radius/provider/leavecalendarprovider.dart';
import 'package:radius/widget/leavecalendar/leavelistcardview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveListView extends StatelessWidget {
  const LeaveListView({super.key});

  @override
  Widget build(BuildContext context) {
    final leavesList =
        Provider.of<LeaveCalendarProvider>(context).employeeLeaveByDayList;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: leavesList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

              },
              child: LeaveListCardView(
                leavesList[index].id,
                leavesList[index].name,
                leavesList[index].avatar,
                leavesList[index].post,
                leavesList[index].days,
              ),
            );
          }),
    );
  }
}
