import 'package:cached_network_image/cached_network_image.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:radius/data/source/network/model/teamsheet/Branch.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/department.dart';
import '../../model/team.dart';
import '../../provider/teamsheetprovider.dart';
import '../../widget/buttonborder.dart';

import '../../widget/radialDecoration.dart';
import 'employeedetailscreen.dart';

class TeamSheetScreen extends StatelessWidget {
  static const routeName = '/teamsheet';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeamSheetProvider(),
      child: TeamSheet(),
    );
  }
}

class TeamSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TeamSheetState();
}

class TeamSheetState extends State<TeamSheet> {
  var initialState = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (initialState) {
      getTeam();
      initialState = false;
    }
    super.didChangeDependencies();
  }

  Future<String> getTeam() async {
    setState(() {
      isLoading = true;
      EasyLoading.show(status: translate('loader.loading'), maskType: EasyLoadingMaskType.black);
    });
    try {
      await Provider.of<TeamSheetProvider>(context, listen: false).getTeam();
      setState(() async {
        isLoading = false;
        EasyLoading.dismiss(animation: true);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        EasyLoading.dismiss(animation: true);
      });
    }

    return "Loaded";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeamSheetProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(translate('team_sheet_screen.team_sheet')),
            elevation: 0,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                return getTeam();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        itemCount: provider.mainTeamList.length,
                        itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: teamCard(provider.mainTeamList.first))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget teamCard(Staff teamList) {
    return Card(
      shape: ButtonBorder(),
      elevation: 0,
      color: Colors.white10,
      child: InkWell(
        onTap: () {
          Get.to(const EmployeeDetailScreen(),
              arguments: {"employeeId": teamList.id.toString()});
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                        teamList == "1" ? Colors.green : Colors.grey,
                        width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: teamList.avatar,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        teamList.name,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(teamList.gender,
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final url = Uri.parse("tel:${teamList.phoneNumber}");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
