import 'package:radius/model/task.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class TaskSection extends StatelessWidget {
  const TaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          translate('project_detail_screen.tasks'),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => ListView.builder(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.project.value.tasks.length,
            itemBuilder: (context, index) {
              Task task = model.project.value.tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                elevation: 0,
                color: Colors.white10,
                child: GestureDetector(
                  onTap: () {
                    Get.to(const TaskDetailScreen(), arguments: {"id": task.id});
                  },
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(task.name!,
                                maxLines: 2,
                                style: const TextStyle(
                                    height: 1.2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15)),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10)),
                          child: Container(
                            width: 10,
                            color: task.status == "Completed"
                                ? Colors.green
                                : Colors.orangeAccent,
                          ),
                        )
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
