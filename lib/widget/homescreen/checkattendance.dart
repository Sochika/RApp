import 'dart:convert';
import 'dart:io';

import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/utils/constant.dart';
import 'package:radius/widget/attendance_bottom_sheet.dart';
import 'package:radius/widget/customalertdialog.dart';
import 'package:radius/widget/customnfcdialog.dart';
import 'package:radius/widget/profile/note_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:one_clock/one_clock.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
// import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class CheckAttendance extends StatefulWidget {
  String formattedDate =
      DateFormat('EEEE , MMMM d , yyyy').format(DateTime.now());

  String nepaliFormattedDate =
      NepaliDateFormat('EEE , MMMM d , yyyy').format(NepaliDateTime.now());

  @override
  State<StatefulWidget> createState() => CheckAttendanceState();
}

class CheckAttendanceState extends State<CheckAttendance> {
  void showNFCScanner() {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: CustomNfcDialog(NFCMODE.scan),
          );
        },
      );
    }

    if (Platform.isIOS) {
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          onAttendanceVerify(
              "nfc", base64.encode(utf8.encode(findKey(tag.data))));
          NfcManager.instance.stopSession();
        },
      );
    }
  }

  // void scanQr() {
  //   QrBarCodeScannerDialog().getScannedQrBarCode(
  //       context: context,
  //       onCode: (code) {
  //         final provider = context.read<DashboardProvider>();
  //         if(provider.isNoteEnabled){
  //           showModalBottomSheet(
  //               context: context,
  //               useRootNavigator: true,
  //               isScrollControlled: true,
  //               builder: (context) {
  //                 return NoteBottomSheet(code??"", "qr");
  //               });
  //         }else{
  //           onAttendanceVerify("qr", code ?? "");
  //         }
  //       });
  // }

  void onAttendanceVerify(String type, String identifier) async {
    final provider = context.read<DashboardProvider>();
    ;
    try {
      setState(() {
        EasyLoading.show(
            status: translate('loader.requesting'), maskType: EasyLoadingMaskType.black);
      });
      final response =
          await provider.verifyAttendanceApi(type,"", identifier: identifier);
      print(response);
      setState(() {
        EasyLoading.dismiss(animation: true);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(response.message),
            );
          },
        );
      });
    } catch (e) {
      setState(() {
        EasyLoading.dismiss(animation: true);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceList =
        Provider.of<DashboardProvider>(context).attendanceList;
    final attandanceType = context.watch<PrefProvider>().attendanceType;
    final isAD = context.watch<DashboardProvider>().isAD;
    final animated = context.watch<DashboardProvider>().animated;
    context.read<PrefProvider>().getAttendanceType();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 0,
                      child: DigitalClock(
                          showSeconds: true,
                          isLive:false,
                          textScaleFactor: .9,
                          format: "a",
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          digitalClockTextColor: Colors.white,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,),
                          datetime: DateTime.now()),
                    ),
                    DigitalClock(
                        showSeconds: true,
                        isLive:false,
                        textScaleFactor: 2.2,
                        format: "HH:mm",
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        digitalClockTextColor: Colors.white,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        datetime: DateTime.now()),
                    Positioned(
                      top: 15,
                      right: 0,
                      child: DigitalClock(
                          showSeconds: true,
                          isLive:false,
                          textScaleFactor: .9,
                          format: "ss",
                          padding: EdgeInsets.zero,
                          digitalClockTextColor: Colors.white,
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          datetime: DateTime.now()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: Text(
            isAD ? widget.formattedDate : widget.nepaliFormattedDate,
            style: const TextStyle(color: Colors.white),
          )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: attendanceList['check-in'] != "-" &&
                              attendanceList['check-out'] == "-"
                          ? HexColor("#e82e5f").withOpacity(.5)
                          : HexColor("#3b98cc").withOpacity(.5),
                      child: IconButton(
                          iconSize: 70,
                          onPressed: () async {
                            if (attandanceType == "QR") {
                              // scanQr();
                              print("QR closed");
                            } else if (attandanceType == "NFC") {
                              bool isAvailable =
                                  await NfcManager.instance.isAvailable();
                              if (!isAvailable) {
                                showToast(
                                    "NFC is not present. Please enable NFC or try different method");
                                return;
                              }
                              showNFCScanner();
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return AttedanceBottomSheet();
                                  });
                            }
                          },
                          icon: Lottie.asset(
                              attandanceType == "QR"
                                  ? 'assets/raw/qr.json'
                                  : attandanceType == "NFC"
                                      ? 'assets/raw/nfc.json'
                                      : 'assets/raw/fingerprint.json',
                              width: 60,
                              height: 60,
                              repeat: animated)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
              child: Text(
            "${translate('home_screen.check_in')} | ${translate('home_screen.check_out')}",
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 30.0,
              padding: const EdgeInsets.all(0),
              percent: attendanceList['production-time']!,
              center: Text(
                attendanceList['production_hour'],
                style: const TextStyle(color: Colors.white),
              ),
              barRadius: const Radius.circular(20),
              backgroundColor: HexColor("#3dFFFFFF"),
              progressColor: attendanceList['check-in'] != "-" &&
                      attendanceList['check-out'] == "-"
                  ? HexColor("#e82e5f")
                  : HexColor("#3b98cc"),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    attendanceList['check-in']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    attendanceList['check-out']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Future<void> checkAd() async {
    final pref = Provider.of<PrefProvider>(context);
    if (await pref.getIsAd()) {
      widget.formattedDate =
          DateFormat('EEEE , MMMM d , yyyy').format(DateTime.now());
    } else {
      widget.formattedDate = NepaliDateFormat('EEE , MMMM d , yyyy')
          .format(DateTime.now().toNepaliDateTime());
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    checkAd();
  }
}
