import 'package:radius/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:radius/widget/buttonborder.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ConfirmBottomSheet extends StatelessWidget {
  const ConfirmBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TaskDetailController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: RadialDecoration(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate('task_detail_screen.mask_as_finish'),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,left: 10,right: 10),
                child: Text(
                  translate('task_detail_screen.checklist_complete'),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: HexColor("#036eb7"),
                                shape: ButtonBorder()),
                            onPressed: () async {
                              Get.back();
                              controller.checkListTaskToggle(controller.taskDetail.value.id.toString());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translate('task_detail_screen.confirm'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: HexColor("#036eb7"),
                                shape: ButtonBorder()),
                            onPressed: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translate('task_detail_screen.go_back'),
                                style: const TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
