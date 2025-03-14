import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/attachmentsection.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/commentsection.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/checklistsection.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/confirmbottomsheet.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/descriptionsection.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/headersection.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/teamsection.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Obx(() => Text(
                  controller.taskDetail.value.projectName!,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
          bottomNavigationBar: Obx(
            () => controller.taskDetail.value.has_checklist == false && controller.taskDetail.value.status != "Completed"
                ? SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                        ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                builder: (context) {
                                  return const ConfirmBottomSheet();
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text(translate('task_detail_screen.mark_as_finish')),
                          )),
                    ),
                )
                : const SizedBox.shrink(),
          ),
          body: Obx(
            () => SafeArea(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.getTaskOverview();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: controller.taskDetail.value.id != 0
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderSection(),
                              DescriptionSection(),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white54,),
                              SizedBox(height: 10,),
                              TeamSection(),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white54,),
                              AttachmentSection(),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white54,),
                              CommentSection(),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white54,),
                              CheckListSection()
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          )),
    );
  }
}
