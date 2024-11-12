import 'package:radius/screen/profile/groupchatscreen.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/widget/attachmentsection.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/widget/descriptionsection.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/widget/headersection.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/widget/tasksection.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/widget/teamsection.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(ProjectDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(GroupChatScreen(), arguments: {
                    "projectId": model.project.value.id,
                    "projectName": model.project.value.name,
                    "projectSlug": model.project.value.slug,
                    "leader": model.project.value.leaders,
                    "member": model.project.value.members,
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                return model.getProjectOverview();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20),
                    child: model.project.value.id == 0
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderSection(),
                              DescriptionSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                              TeamSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                              AttachmentSection(),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.white54,
                              ),
                              Obx(() => model.project.value.tasks.length != 0
                                  ? TaskSection()
                                  : SizedBox())
                            ],
                          ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
