
import 'package:radius/provider/profileprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Heading extends StatefulWidget {
  const Heading({super.key});

  @override
  State<StatefulWidget> createState() => HeadingState();
}

class HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final profile = Provider.of<ProfileProvider>(context).profile;
    final isProfileLoading = Provider.of<ProfileProvider>(context,listen: true).profile;
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profile.avatar))),
                    alignment: Alignment.bottomCenter)),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.username,
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
                Text(
                  profile.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    profile.email,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                // IgnorePointer(
                //   ignoring: isProfileLoading.phone == ""?true:false,
                //   child: GestureDetector(
                //     onTap: () {
                //       ProfileScreen();
                //     },
                //     child: Card(
                //       margin: const EdgeInsets.only(top: 10),
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(10),
                //             bottomRight: Radius.circular(10)),
                //       ),
                //       color: HexColor("#036eb7"),
                //       child: const Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Text(
                //           "Logout",
                //           style: TextStyle(color: Colors.white, fontSize: 15),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
