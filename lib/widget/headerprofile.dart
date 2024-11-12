import 'package:cached_network_image/cached_network_image.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/screen/profile/NotificationScreen.dart';
import 'package:radius/screen/profile/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class HeaderProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<HeaderProfile> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrefProvider>(context);
    return GestureDetector(
      onTap: () {
        pushScreen(context,
            screen: ProfileScreen(),
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
                imageUrl: provider.avatar,
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
                    provider.userName,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  pushScreen(context,
                      screen: NotificationScreen(),
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
