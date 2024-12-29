import 'package:radius/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectDetailController model = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: Colors.white24,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Obx(() => Text(
                  model.project.value.priority,
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              model.project.value.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Row(
                  children: [
                    Text(
                      "${translate('project_detail_screen.due_date')}:  ",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                        model.project.value.date,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: model.project.value.status == "In Progress"
                  ? HexColor("#80C1E1C1")
                  : model.project.value.status == "Not Started"
                      ? HexColor("#C9CC3F")
                      : model.project.value.status == "On Hold"
                          ? HexColor("#93C572")
                          : HexColor("#3cb116"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Obx(
                  () => Text(
                    model.project.value.status,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
