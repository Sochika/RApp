import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/screen/awards/awarddetailsscreen.dart';
import 'package:radius/screen/awards/awardsscreen.dart';
import 'package:radius/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RecentAward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final award = context.watch<DashboardProvider>().award;
    return Visibility(
      visible: award != null ? true : false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  translate('home_screen.recent_award'),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(AwardsScreen());
                  },
                  child: Text(
                    translate('home_screen.show_all'),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            award != null
                ? GestureDetector(
                    onTap: () {
                      Get.to(AwardDetailScreen(), arguments: {"award": award});
                    },
                    child: Card(
                      shape: ButtonBorder(),
                      elevation: 0,
                      color: Colors.white12,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    color: Colors.deepOrange,
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Text(
                                        award.award_name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    award.employee_name,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    award.awarded_date,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              ClipOval(
                                child: Image.network(
                                  award.image,
                                  width: 60,
                                  height: 60,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
