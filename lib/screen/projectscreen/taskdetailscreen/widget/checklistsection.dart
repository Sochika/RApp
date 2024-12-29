import 'package:radius/model/checklist.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class CheckListSection extends StatelessWidget {
  const CheckListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          translate('task_detail_screen.checklists'),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => controller.taskDetail.value.checkList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      translate('task_detail_screen.no_checklist_found'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.taskDetail.value.checkList.length,
                  itemBuilder: (context, index) {
                    Checklist checklist =
                        controller.taskDetail.value.checkList[index];
                    var state = false.obs;
                    state.value = checklist.isCompleted == "0" ? false : true;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      elevation: 0,
                      color: Colors.white10,
                      child: InkWell(
                        onTap: () async {
                          final response =
                              await controller.checkListToggle(
                              checklist.id.toString());

                          if (response) {
                            state.toggle();
                            checklist.isCompleted =
                            state.value == false ? "0" : "1";
                            state.refresh();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(
                                () => Icon(
                                  state == true
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: state == true
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(checklist.name,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
}
