import 'package:cached_network_image/cached_network_image.dart';
import 'package:radius/provider/meetingprovider.dart';
import 'package:radius/screen/profile/employeedetailscreen.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeetingDetailScreen extends StatefulWidget {
  static const routeName = '/meetingdetailscreen';

  const MeetingDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => MeetingDetailState();
}

class MeetingDetailState extends State<MeetingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    final item = Provider.of<MeetingProvider>(context)
        .meetingList
        .where((item) => item.id == args)
        .first;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(translate('meeting_detail_screen.meeting_detail')),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                item.image == ""
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: item.image,
                                height: 200,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              )),
                          gaps(10),
                        ],
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.white,
                    ),
                    Text(
                      item.venue,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
                gaps(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    item.title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                gaps(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${translate('meeting_detail_screen.date')} - ${item.meetingDate} ${item.meetingStartTime}',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                gaps(10),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Host: ',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          item.createdBy,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                gaps(10),
                Html(
                  style: {
                    "body": Style(
                        color: Colors.white70,
                        fontSize: FontSize.large,
                        textAlign: TextAlign.justify)
                  },
                  data: item.agenda,
                ),
                gaps(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    translate('meeting_detail_screen.participants'),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                gaps(10),
                ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(const EmployeeDetailScreen(), arguments: {
                            "employeeId": item.participator[index].id
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: ListTile(
                            title: Text(
                              item.participator[index].name,
                              style: const TextStyle(fontSize: 15),
                            ),
                            trailing: Text(
                              item.participator[index].post,
                              style: const TextStyle(fontSize: 15),
                            ),
                            textColor: Colors.white,
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: item.participator[index].avatar,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.white12,
                      );
                    },
                    itemCount: item.participator.length)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gaps(int value) {
    return const SizedBox(
      height: 10,
    );
  }
}
