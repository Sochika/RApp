import 'package:radius/model/task.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:radius/screen/projectscreen/tasklistscreen/tasklistscontroller.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(TaskListController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(translate('task_list_screen.tasks')),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return model.getTaskList();
            },
            child: Container(
              child: Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(
                        10),bottomRight: Radius.circular(10))),
                    color: Colors.white12,
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = "All";
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == "All"
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        translate('task_list_screen.all'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = "In Progress";
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == "In Progress"
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        translate('task_list_screen.in_progress'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = "Completed";
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == "Completed"
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        translate('task_list_screen.completed'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = "On Hold";
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == "On Hold"
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        translate('task_list_screen.on_hold'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = "Cancelled";
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == "Cancelled"
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        translate('task_list_screen.cancelled'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = "Not Started";
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == "Not Started"
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15),
                                      child: Text(
                                        translate('task_list_screen.not_started'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Obx(
                      () => model.filteredList.isEmpty
                          ? SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Container(),
                            )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                              primary: false,
                              itemCount: model.filteredList.length,
                              itemBuilder: (context, index) {
                                Task item = model.filteredList[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(const TaskDetailScreen(), arguments: {"id": item.id});
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                                    color: Colors.white12,
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                        const Icon(Icons.work,color: Colors.white54,size: 15,),
                                                        const SizedBox(width: 5,),
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
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CircularPercentIndicator(
                                                radius: 30.0,
                                                animation: true,
                                                animationDuration: 1200,
                                                lineWidth: 7.0,
                                                percent: (item.progress! / 100),
                                                center: Text(
                                                    item.progress.toString(),
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12.0,
                                                        color: Colors.white),
                                                  ),
                                                circularStrokeCap: CircularStrokeCap.round,
                                                backgroundColor: Colors.white12,
                                                progressColor:
                                                (item.progress! / 100) <= .25
                                                    ? HexColor("#C1E1C1")
                                                    : (item.progress! / 100) <= .50
                                                    ? HexColor("#C9CC3F")
                                                    : (item.progress! / 100) <= .75
                                                    ? HexColor("#93C572")
                                                    : HexColor("#3cb116"),
                                              )
                                            ],
                                          ),
                                          const Divider(color: Colors.white24),
                                          const SizedBox(
                                            height: 0,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
