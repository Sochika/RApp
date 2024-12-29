import 'package:cached_network_image/cached_network_image.dart';
import 'package:radius/widget/buttonborder.dart';
import 'package:flutter/material.dart';

class LeaveListCardView extends StatelessWidget {
  final String id;
  final String name;
  final String avatar;
  final String post;
  final String leaveDays;

  const LeaveListCardView(this.id,this.name, this.avatar, this.post, this.leaveDays, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white12,
      elevation: 0,
      shape: ButtonBorder(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                imageUrl: avatar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  post,
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                ),
              ],
            ),
            const Spacer(),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.green,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              leaveDays,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Days',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
                Visibility(
                  visible: id == "0",
                  child: const Positioned(
                    right: 0,
                    child: Card(
                      shape: CircleBorder(),
                      elevation: 0,
                      color: Colors.white,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text("⏱️"),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
