import 'package:radius/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget{
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectDetailController model = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          translate('project_detail_screen.description'),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(() =>ReadMoreText(
            parse(model.project.value.description).body!.text,
            trimLines: 4,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' ${translate('project_detail_screen.show_more')}',
            trimExpandedText: ' ${translate('project_detail_screen.show_less')}',
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            lessStyle: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            moreStyle: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

}