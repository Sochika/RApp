import 'package:radius/provider/projectdashboardcontroller.dart';
import 'package:radius/screen/traning/trainingdetailsscreen.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TrainingScreen extends StatelessWidget {
  final model = Get.put(ProjectDashboardController());
  final progress = 20;
  final completedTraining = 2;
  final totalTraining = 10;

   TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text("Trainings"),
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
                  trainingOverview(),
                  recentTrainings(),
                  allTrainings()
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget trainingOverview() {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      color: Colors.white12,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 15.0,
              percent: (progress / 100),
              center: Text(
                "$progress%",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.white12,
              progressColor: (progress / 100) <= .25
                  ? HexColor("#C1E1C1")
                  : (progress / 100) <= .50
                      ? HexColor("#C9CC3F")
                      : (progress / 100) <= .75
                          ? HexColor("#93C572")
                          : HexColor("#3cb116"),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Current Training Progress",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const Divider(
                    color: Colors.white54,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Text(
                      "$completedTraining / $totalTraining Training Completed",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget recentTrainings() {
    return Visibility(
      visible: model.projectList.isEmpty ? false : true,
      child: Container(
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Trainings",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(TrainingDetailScreen());
                  },
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    color: Colors.white12,
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: const Column(
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Text(
                                      "Application",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.model_training,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text("Flutter Development",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            height: 1.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("19 June 2024",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("-",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.calendar_month,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("25 June 2024",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("03 : 00 AM",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12)),
                                ],
                              ),
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
    );
  }

  Widget allTrainings() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Trainings",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  color: Colors.white12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: const Column(
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5),
                                  child: Text(
                                    "Application",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.model_training,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text("Flutter Development",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          height: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("19 June 2024",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("-",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.calendar_month,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("25 June 2024",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("03 : 00 AM",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                              ],
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
        ],
      ),
    );
  }
}
