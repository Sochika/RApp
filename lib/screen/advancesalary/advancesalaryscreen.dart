import 'package:radius/model/advancesalary.dart';
import 'package:radius/provider/advancesalarylistcontroller.dart';
import 'package:radius/utils/constant.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class AdvanceSalaryScreen extends StatelessWidget {
  const AdvanceSalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(AdvanceSalaryController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(translate('advance_salary_screen.advance_salary')),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.onAdvanceSalaryCreateClicked();
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add)),
        body: Obx(
          () => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return model.getTadaList();
                },
                child: ListView.builder(
                  itemCount: model.salaryList.length,
                  itemBuilder: (context, index) {
                    AdvanceSalary item = model.salaryList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10))),
                        tileColor: Colors.white12,
                        onTap: () {
                          model.onAdvanceSalaryClicked(item.id.toString());
                        },
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        title: Text(
                          item.requested_amount,
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          item.submittedDate,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            if(item.status.toLowerCase() == "pending"){
                              model.onAdvanceSalaryEditClicked(item.id.toString());
                            }else{
                              showToast("Accepted/Rejected Advance can't be edited");
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.edit),
                          ),
                        ),
                        leading: Card(
                            color: item.status.toLowerCase() == "pending"
                                ? Colors.orange
                                : item.status.toLowerCase() == "rejected"
                                    ? Colors.red
                                    : Colors.green,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                item.status.toLowerCase() == "pending"
                                    ? "P"
                                    : item.status.toLowerCase() == "rejected"
                                        ? "R"
                                        : "A",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
