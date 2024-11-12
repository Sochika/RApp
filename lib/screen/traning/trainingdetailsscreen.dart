import 'package:radius/screen/traning/trainingdetailcontroller.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class TrainingDetailScreen extends StatelessWidget {
  final model = Get.put(TrainingDetailController());
  final trainingStatus = "In Progress";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Training Detail"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.white24,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3),
                        child: Text(
                          "Application",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Flutter Development",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              children: [
                                Text(
                                  "Start Date:  ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "19 June 2024",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              children: [
                                Text(
                                  "End Date:  ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "24 June 2024",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "05 : 00 PM",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Card(
                          margin: EdgeInsets.zero,
                          color: trainingStatus == "In Progress"
                              ? HexColor("#80C1E1C1")
                              : trainingStatus == "Not Started"
                                  ? HexColor("#C9CC3F")
                                  : trainingStatus == "On Hold"
                                      ? HexColor("#93C572")
                                      : HexColor("#3cb116"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: Text(
                              trainingStatus,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Description",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor, nisl non finibus feugiat, justo dui aliquet quam, vel auctor augue neque quis enim. Cras congue posuere fermentum. Integer in justo ac libero ornare efficitur sit amet venenatis urna. Vivamus pharetra, sem at mollis tempor, ex urna accumsan ligula, eu faucibus risus lorem sit amet quam. Vivamus et lobortis ligula. Donec sem dolor, congue nec eros et, euismod rhoncus enim. Vestibulum pulvinar sodales mauris nec sodales. Fusce venenatis pretium tellus ac sagittis. Nam tempor sem non fermentum fringilla. Donec convallis consectetur augue eget porttitor. In non dui in justo vehicula.",
                      trimLines: 15,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      lessStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      moreStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Certificate",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () async {
                              final value = await model
                                  .checkAndRequestStoragePermission();

                              if (value) {
                                model.saveFileLocally(
                                    "https://cdn.slidesharecdn.com/ss_thumbnails/demo-teaching-cert-240312003520-3bddcef4-thumbnail.jpg");
                              }
                              print(value);
                            },
                            child: Icon(
                              Icons.download,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      "https://cdn.slidesharecdn.com/ss_thumbnails/demo-teaching-cert-240312003520-3bddcef4-thumbnail.jpg",
                      height: 300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
