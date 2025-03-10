import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/screen/awards/awardsscreen.dart';
import 'package:radius/screen/dashboard/projectscreen.dart';
import 'package:flutter/material.dart';
import 'package:radius/widget/homescreen/cardoverview.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:radius/data/source/network/model/dashboard/Dashboardresponse.dart';

class OverviewDashboard extends StatelessWidget {
  PersistentTabController controller;
  // int beatNo;
  // OverviewDashboard(this.controller, this.beatNo, {super.key});
  final Dashboardresponse? dashboardData;

   OverviewDashboard(this.controller, this.dashboardData, {super.key});

  @override
  Widget build(BuildContext context) {
    // print(dashboardData?.data.shifts);
    // final overview = Provider.of<DashboardProvider>(context).getOverview();
    // print(overview.);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translate('home_screen.overview'),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     CardOverView(
          //       type: "On Duty",
          //       value: overview['present']!,
          //       icon: "assets/icons/present_icon.png",
          //       callback: () {
          //         // controller.jumpToTab(2);
          //       },
          //     ),
          //     // CardOverView(
          //     //   type: translate('home_screen.holidays'),
          //     //   value: _overview['holiday']!,
          //     //   icon: Icons.celebration,
          //     //   callback: () {
          //     //     pushScreen(context,
          //     //         screen: HolidayScreen(),
          //     //         withNavBar: false,
          //     //         pageTransitionAnimation: PageTransitionAnimation.fade);
          //     //   },
          //     // )
          //     // CardOverView(
          //     //   type: "Absent",
          //     //   value: overview['leave']!,
          //     //   icon: Icons.sick,
          //     //   callback: () {
          //     //     // controller.jumpToTab(1);
          //     //   },
          //     // ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardOverView(
                type: "Beats",
                value: dashboardData?.data.shifts.length.toString() ?? '0',
                icon: Icons.work_history_outlined,
                callback: () {
                  pushScreen(context,
                      screen: ProjectScreen(dashboardData),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
              CardOverView(
                type: translate('home_screen.request'),
                value: '0',
                icon: Icons.pending,
                callback: () {
                  // controller.jumpToTab(1);
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              CardOverView(
                type: "Training",
                value: '0',
                icon: Icons.model_training_rounded,
                callback: () {
                  // pushScreen(context,
                  //     screen: ProjectScreen(),
                  //     withNavBar: false,
                  //     pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
              CardOverView(
                type: "On Duty",
                value: '0',
                icon: "assets/icons/present_icon.png",
                callback: () {
                  // controller.jumpToTab(2);
                },
              ),

            ],
          ),

        ],
      ),
    );
  }
}
