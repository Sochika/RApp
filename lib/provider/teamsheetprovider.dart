import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radius/data/source/network/model/teamsheet/Branch.dart';

import '../model/department.dart';
import '../model/team.dart';
import '../repositories/teamsheetrepository.dart';

class TeamSheetProvider with ChangeNotifier {
  TeamSheetRepository repository = TeamSheetRepository();
  final List<Team> _teamList = [];

  final List<Staff> mainTeamList = [];

  // final List<Branch> _branches = [];
  final List<ShiftOperative> _department = [];

  int selectedBranch = 0;
  int selectedDepartment = 0;

// Staff pro



  void createTeam(List<Staff> staffs) {
    for (var employee in staffs) {
      FirebaseFirestore.instance
          .collection('staff_and_shifts')
          .doc(employee.name.toString())
          .set({
        'name': employee.name,
        'phone': employee.phoneNumber,
        'email': employee.id,

        'id': employee.id,
        'avatar': employee.avatar,

        'gender': employee.gender,
      });
    }
  }

  Future<void> getTeam() async {
    try {
      final response = await repository.getTeam();
      makeBeatSheet(response.data.shiftOperative);



      makeTeamList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void makeTeamList() {
    _teamList.clear();

    notifyListeners();
  }

  void makeTeamSheet(List<Staff> shifts) {
    mainTeamList.clear();
    for (var value in shifts) {
      mainTeamList.add(Staff(
          id: value.id,
          name: value.name,
          phoneNumber: value.phoneNumber, gender: value.gender, avatar: value.avatar),);

    }
    notifyListeners();
  }


  void makeBeatSheet(List<ShiftOperative> shifts) {
    mainTeamList.clear();
    for (var value in shifts) {
      _department.add(ShiftOperative(
          beatBranchId: value.beatBranchId,
          beatBranchName: value.beatBranchName,
          area: value.area,
          latitude: value.longitude,
          longitude: value.longitude, staffAndShifts: value.staffAndShifts,));

      makeTeamSheet(value.staffAndShifts.cast<Staff>());
          }
          notifyListeners();
      }
}
