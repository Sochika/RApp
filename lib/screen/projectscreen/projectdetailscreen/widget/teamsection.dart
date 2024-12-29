import 'package:radius/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:radius/screen/projectscreen/projectdetailscreen/widget/teambottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(TeamBottomSheet(model.project.value.leaders,model.project.value.members,),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: false,
            ignoreSafeArea: true);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate('project_detail_screen.team_leads'),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                translate('project_detail_screen.view_all'),
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() =>ImageStack(
                  imageList: List<String>.from(model.memberImages),
                  totalCount: model.project.value.members.length,
                  imageRadius: 25,
                  imageCount: 4,
                  imageBorderColor: Colors.white,
                  imageBorderWidth: 1,
                ),
              ),
              Obx(() => ImageStack(
                  imageList: List<String>.from(model.leaderImages),
                  totalCount: model.project.value.leaders.length,
                  imageRadius: 25,
                  imageCount: 1,
                  imageBorderColor: Colors.white,
                  imageBorderWidth: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
