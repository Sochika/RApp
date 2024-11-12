import 'dart:convert';

import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/data/source/network/model/projectdashboard/ProjectDashboardResponse.dart';
import 'package:radius/model/member.dart';
import 'package:radius/model/project.dart';
import 'package:radius/model/task.dart';
import 'package:radius/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class ProjectDashboardController extends GetxController {
  var overview = {
    "progress": 0,
    "total_task": 0,
    "task_completed": 0,
  }.obs;

  var taskList = [].obs;
  var projectList = [].obs;

  Future<String> getProjectOverview() async {
    Preferences preferences = Preferences();
    var uri =
        Uri.parse(await preferences.getAppUrl()+Constant.PROJECT_DASHBOARD_URL + "?tasks=10&projects=3");

    String token = await preferences.getToken();
    bool isAd = await preferences.getEnglishDate();

    Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body.toString());

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final projectResponse = ProjectDashboardResponse.fromJson(responseData);

        taskList.clear();
        projectList.clear();

        overview.value['progress'] =
            projectResponse.data.progress.progress_in_percent;
        overview.value['total_task'] =
            projectResponse.data.progress.total_task_assigned;
        overview.value['task_completed'] =
            projectResponse.data.progress.total_task_completed;

        for (var task in projectResponse.data.assigned_task) {
          DateTime startDate = DateFormat("MMM dd yyyy","en").parse(task.start_date);
          DateTime endDate = DateFormat("MMM dd yyyy","en").parse(task.end_date);

          NepaliDateTime nepaliStartDate = startDate.toNepaliDateTime();
          NepaliDateTime nepaliEndDate = endDate.toNepaliDateTime();

          String nepaliStartTempDate =
              NepaliDateFormat("MMM dd yyyy").format(nepaliStartDate);
          String nepaliEndTempDate =
              NepaliDateFormat("MMM dd yyyy").format(nepaliEndDate);

          taskList.add(Task(
              task.task_id,
              task.task_name,
              task.project_name,
              isAd ? task.start_date : nepaliStartTempDate,
              isAd ? task.end_date : nepaliEndTempDate,
              task.status));
        }

        List<Member> members = [];
        for (var project in projectResponse.data.projects) {
          for (var member in project.assigned_member) {
            members.add(Member(member.id, member.name, member.avatar));
          }

          DateTime tempDate =
              DateFormat("MMM dd yyyy","en").parse(project.start_date);
          NepaliDateTime nepaliDate = tempDate.toNepaliDateTime();

          String nepaliTempDate =
              NepaliDateFormat("MMM dd yyyy").format(nepaliDate);

          projectList.add(Project(
              project.id,
              project.project_name,
              project.slug,
              "",
              isAd ? project.start_date : nepaliTempDate,
              project.priority,
              project.status,
              project.project_progress_percent,
              project.assigned_task_count,
              members, [], []));
        }

        return "Loaded";
      } else {
        var errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
  }

  @override
  void onInit() {
    getProjectOverview();
    super.onInit();
  }
}