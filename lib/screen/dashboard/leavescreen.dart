import 'package:radius/utils/constant.dart';
import 'package:radius/widget/buttonborder.dart';
import 'package:radius/widget/headerprofile.dart';
import 'package:radius/widget/leavescreen/leave_list_dashboard.dart';
import 'package:radius/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:radius/widget/leavescreen/leavebutton.dart';
import 'package:radius/widget/leavescreen/leavetypefilter.dart';
import 'package:radius/widget/leavescreen/toggleleavetime.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';
import 'package:radius/provider/leaveprovider.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<StatefulWidget> createState() => LeaveScreenState();
}

class LeaveScreenState extends State<LeaveScreen> with WidgetsBindingObserver {
  var init = true;
  var isVisible = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }

    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final leaveData = await leaveProvider.getLeaveType();

    if (!mounted) {
      return "Loaded";
    }
    if (leaveData.statusCode != 200) {
      showToast(leaveData.message);
    }

    getLeaveDetailList();
    return "Loaded";
  }

  void getLeaveDetailList() async {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final detailResponse = await leaveProvider.getLeaveTypeDetail();

    if (!mounted) {
      return;
    }
    if (detailResponse.statusCode == 200) {
      isVisible = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          padding: const EdgeInsets.all(20), content: Text(detailResponse.message)));
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
            initialState();
          },
          child: SafeArea(
              child: RefreshIndicator(
            onRefresh: () {
              return initialState();
            },
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeaderProfile(),
                    Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: double.infinity,
                        child: Text(
                          translate('leave_screen.leave'),
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        )),
                    const LeaveListDashboard(),
                    Visibility(
                      visible: isVisible,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: LeaveButton()),
                    ),
                    const SizedBox(height: 20,),
                    Visibility(
                      visible: isVisible,
                      child: Text(translate('leave_screen.recent_leave_activity'),style: const TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                    const SizedBox(height: 10,),
                    Stack(
                      children: [
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 25),
                            child: Card(
                              color: Colors.white12,
                              shape: ButtonBorder(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: isVisible,
                                      child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10),
                                          child: LeavetypeFilter()),
                                    ),
                                    Visibility(
                                        visible: isVisible, child: const LeaveListdetailDashboard()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Visibility(
                            visible: isVisible,
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: ToggleLeaveTime()),
                          ),
                        )
                      ],
                    )
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
