import 'package:radius/model/project.dart';
import 'package:radius/model/task.dart';
import 'package:radius/provider/projectdashboardcontroller.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/projectdetailscreen.dart';
import 'package:radius/screen/projectscreen/projectlistscreen/projectlistscreen.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:radius/screen/projectscreen/tasklistscreen/tasklistscreen.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_stack/image_stack.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/source/network/model/dashboard/Dashboardresponse.dart';
import '../../utils/TagWidget.dart';

class ProjectScreen extends StatelessWidget {
  final model = Get.put(ProjectDashboardController());
  final Dashboardresponse? dashboardData;

   ProjectScreen(this.dashboardData,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Beat Management'),
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: Colors.white,
          backgroundColor: Colors.blueGrey,
          edgeOffset: 50,
          onRefresh: () {
            return model.getProjectOverview();
          },
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  // projectOverview(),
                  dashboardDataList(),
                  recentProject(), recentTasks()],
              ),
            ),
          )),
        ),
      ),
    );
  }

  // Widget projectOverview() {
  //   return Card(
  //     elevation: 0,
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
  //     color: Colors.white12,
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     child: Container(
  //       padding: const EdgeInsets.all(20),
  //       child: Row(
  //         children: [
  //           Obx(
  //             () => CircularPercentIndicator(
  //               radius: 60.0,
  //               animation: true,
  //               animationDuration: 1200,
  //               lineWidth: 15.0,
  //               percent: (model.overview.value['progress']! / 100),
  //               center: Obx(
  //                 () => Text(
  //                   "${model.overview.value['progress']}%",
  //                   style: const TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20.0,
  //                       color: Colors.white),
  //                 ),
  //               ),
  //               circularStrokeCap: CircularStrokeCap.round,
  //               backgroundColor: Colors.white12,
  //               progressColor: (model.overview.value['progress']! / 100) <= .25
  //                   ? HexColor("#C1E1C1")
  //                   : (model.overview.value['progress']! / 100) <= .50
  //                       ? HexColor("#C9CC3F")
  //                       : (model.overview.value['progress']! / 100) <= .75
  //                           ? HexColor("#93C572")
  //                           : HexColor("#3cb116"),
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 20,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(translate('project_screen.progress_current_task'),
  //                     style: const TextStyle(
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 20)),
  //                 const Divider(
  //                   color: Colors.white54,
  //                   endIndent: 0,
  //                   indent: 0,
  //                 ),
  //                 Obx(
  //                   () => Text(
  //                       "${model.overview.value['task_completed']} / ${model.overview.value['total_task']} ${translate('project_screen.task_completed')}",
  //                       style: const TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.normal,
  //                           fontSize: 12)),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget dashboardDataList() {
    if (dashboardData == null) {
      return const Center(
        child: Text(
          'No dashboard data available.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Assuming `dashboardData.data` is a list of items.
    var dataList = dashboardData!.data.shifts;

    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        var item = dataList[index]; // Assuming each item is a map or object.

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
            color: Colors.white12,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.beatBranch.name ?? 'No Title', // Change this based on your data structure
                    style: const TextStyle(
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        item.beatBranch.area?? 'No Description', // Update as per your schema
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${item.shiftStart} to ${item.shiftEnd} '?? 'No Description', // Update as per your schema
                        style: const TextStyle(color: Colors.orange, fontSize: 14),
                      ),
                      // TagWidget(label: item.shiftType.name ?? '', backgroundColor:  Colors.blueAccent, textColor:  Colors.white)
                    ],
                  ),
                  Row(
                    children: [
                      item.mainAssign == 1 ? const TagWidget(label: 'Primary', backgroundColor:  Colors.blueAccent, textColor:  Colors.white) : const TagWidget(label: 'Secondary', backgroundColor:  Colors.blueGrey, textColor:  Colors.white) ,

                    ]
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget recentProject() {
    return Obx(
      () => Visibility(
        visible: model.projectList.isEmpty ? false : true,
        child: Container(
          height: 270,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('project_screen.recent_projects'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const ProjectListScreen());
                    },
                    child: Text(
                      translate('project_screen.view_all'),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: model.projectList.length,
                itemBuilder: (context, index) {
                  Project item = model.projectList[index];
                  var memberImages = [];

                  for (var member in item.members) {
                    memberImages.add(member.image);
                  }

                  return GestureDetector(
                    onTap: () {
                      Get.to(const ProjectDetailScreen(), arguments: {"id": item.id});
                    },
                    child: Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      color: Colors.white12,
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 0,
                                    color: Colors.white12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Text(
                                        item.priority,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.work,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(item.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              height: 1.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.calendar_month,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(item.date,
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12)),
                                    const Spacer(),
                                    const Icon(
                                      Icons.flag,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(item.noOfTask.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12)),
                                  ],
                                ),
                              ],
                            ),
                            ImageStack(
                              imageList: List<String>.from(memberImages),
                              totalCount: memberImages.length,
                              imageRadius: 25,
                              imageCount: 4,
                              imageBorderColor: Colors.white,
                              imageBorderWidth: 1,
                            ),
                            Column(
                              children: [
                                LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  percent: item.progress / 100,
                                  lineHeight: 10,
                                  barRadius: const Radius.circular(20),
                                  backgroundColor: Colors.white12,
                                  progressColor: item.progress <= 25
                                      ? HexColor("#C1E1C1")
                                      : item.progress <= 50
                                          ? HexColor("#C9CC3F")
                                          : item.progress <= 75
                                              ? HexColor("#93C572")
                                              : HexColor("#3cb116"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.status,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text("${item.progress}%",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget recentTasks() {
    return Obx(
      () => Visibility(
        visible: model.taskList.isEmpty ? false : true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('project_screen.recent_tasks'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const TaskListScreen(),
                          transition: Transition.cupertino);
                    },
                    child: Text(
                      translate('project_screen.view_all'),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: model.taskList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Task item = model.taskList[index];
                    return InkWell(
                      onTap: () {
                        Get.to(const TaskDetailScreen(), arguments: {"id": item.id});
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        color: Colors.white12,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          item.name!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.work,
                                              color: Colors.white54,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              maxLines: 1,
                                              item.projectName!,
                                              style: const TextStyle(
                                                  color: Colors.white54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(color: Colors.white24),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${item.date!}-${item.endDate!}",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: item.status == "In Progress"
                                        ? HexColor("#80C1E1C1")
                                        : item.status == "Not Started"
                                            ? HexColor("#C9CC3F")
                                            : item.status == "On Hold"
                                                ? HexColor("#93C572")
                                                : HexColor("#3cb116"),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Text(
                                        item.status,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
