import 'package:radius/provider/holidayprovider.dart';
import 'package:radius/widget/holiday/holidaycard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HolidayCardView extends StatelessWidget {
  const HolidayCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final holidayList = Provider.of<HolidayProvider>(context).holidayList;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: holidayList.length,
          itemBuilder: (ctx, i) {
            return Holidaycard(
              id: holidayList[i].id,
              name: holidayList[i].title,
              month: holidayList[i].month,
              day: holidayList[i].day,
              desc: holidayList[i].description,
              isPublicHoliday: holidayList[i].isPublicHoliday,
            );
          }),
    );
  }
}
