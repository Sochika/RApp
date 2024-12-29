import 'package:radius/provider/holidayprovider.dart';
import 'package:radius/widget/holiday/holidaycardview.dart';
import 'package:radius/widget/holiday/toggleholiday.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class HolidayScreen extends StatelessWidget {
  static const routeName = '/holidays';

  const HolidayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HolidayProvider(),
      child: const Holiday(),
    );
  }
}

class Holiday extends StatefulWidget {
  const Holiday({super.key});

  @override
  State<StatefulWidget> createState() => HolidayState();
}

class HolidayState extends State<Holiday> {
  var inital = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (inital) {
      loadHolidays();
      inital = false;
    }
    super.didChangeDependencies();
  }

  Future<String> loadHolidays() async {
    setState(()  {
      isLoading = true;
      EasyLoading.show(status: translate('loader.loading'), maskType: EasyLoadingMaskType.black);
    });

    await Provider.of<HolidayProvider>(context, listen: false).getHolidays();
    setState(()  {
      isLoading = false;
      EasyLoading.dismiss(animation: true);
    });

    return "loaded";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(translate('holiday_screen.holidays'), style: const TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return loadHolidays();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                child: const Column(
                  children: [ToggleHoliday(), HolidayCardView()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
