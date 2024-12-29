import 'package:radius/provider/leavecalendarprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CalendarToggle extends StatelessWidget {
  const CalendarToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final toggle = context.watch<LeaveCalendarProvider>().toggleValue;
    return Center(
      child: ToggleSwitch(
        activeBgColor: const [Colors.white12],
        activeFgColor: Colors.white,
        inactiveFgColor: Colors.white,
        inactiveBgColor: Colors.transparent,
        minWidth: 100,
        minHeight: 45,
        initialLabelIndex: toggle,
        totalSwitches: 3,
        onToggle: (index) {
          context.read<LeaveCalendarProvider>().changeToggle(index ?? 0);
        },
        labels: [
          translate('common.leave'),
          translate('common.holiday'),
          translate('common.birthday')
        ],
      ),
    );
  }
}
