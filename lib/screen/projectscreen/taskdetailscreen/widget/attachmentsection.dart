import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:radius/screen/projectscreen/taskdetailscreen/widget/attachmentbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class AttachmentSection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final TaskDetailController model = Get.find();
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(AttachmentBottomSheet(),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: true,
            ignoreSafeArea: true);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                translate('task_detail_screen.attachments'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                translate('task_detail_screen.show_media'),
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(height: 10),
          Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${translate('task_detail_screen.file_images')} ( ${model.taskDetail.value.attachments.length} )",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}