import 'package:radius/model/attachment.dart';
import 'package:radius/screen/tadascreen/widget/fileslistbottom.dart';
import 'package:radius/screen/tadascreen/widget/imagelistbottom.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentBottomSheet extends StatelessWidget {
  List<Attachment> attachments;

  AttachmentBottomSheet(this.attachments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: RadialDecoration(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Attachments",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Image",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  "Files",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: [
                  ItemListBottom(attachments),
                  FilesListBottom(attachments),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
