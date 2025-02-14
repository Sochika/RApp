import 'package:cached_network_image/cached_network_image.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/screen/profile/NotificationScreen.dart';
import 'package:radius/screen/profile/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

import '../utils/constant.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key});

  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<HeaderProfile> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrefProvider>(context);
    // print('Hello from profile_dash${provider.staffNo}');
    // print('mypic${provider.avatar}');
    return GestureDetector(
      onTap: () {
        pushScreen(context,
            screen: const ProfileScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: CachedNetworkImage(
                imageUrl: '${Constant.IMAGE_URL}${provider.avatar}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Image.asset(
                    'assets/images/dummy_avatar.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                   "Hello Operative",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),

                  Text(
                    provider.fullname,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    provider.staffNo,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  pushScreen(context,
                      screen: const NotificationScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
