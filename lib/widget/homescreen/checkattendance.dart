import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:one_clock/one_clock.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/widget/attendance_bottom_sheet.dart';
import 'package:radius/widget/customalertdialog.dart';

class CheckAttendance extends StatefulWidget {
  final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
  final String nepaliFormattedDate =
  NepaliDateFormat('EEE, MMMM d, yyyy').format(NepaliDateTime.now());

  CheckAttendance({super.key});

  @override
  State<StatefulWidget> createState() => _CheckAttendanceState();
}

class _CheckAttendanceState extends State<CheckAttendance> {
  late String formattedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateFormattedDate();
  }

  Future<void> updateFormattedDate() async {
    final prefProvider = Provider.of<PrefProvider>(context, listen: false);
    formattedDate = await prefProvider.getIsAd()
        ? DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now())
        : NepaliDateFormat('EEE, MMMM d, yyyy').format(DateTime.now().toNepaliDateTime());
    setState(() {});
  }

  Future<String> checkLocation(
      double targetLatitude,
      double targetLongitude,
      {double thresholdDistance = 100}
      ) async {
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return "Location permission denied. Please grant permission.";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return "Location permission is permanently denied. Please enable it in settings.";
      }

      // Get current or last known position
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      } catch (_) {
        position = await Geolocator.getLastKnownPosition();
        if (position == null) return "Unable to retrieve location.";
      }

      // Calculate the distance to the target location
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        targetLatitude,
        targetLongitude,
      );

      // Debugging: Print the current position
      print('Current Position: ${position.latitude}, ${position.longitude}');

      // Check if within threshold distance
      return distance <= thresholdDistance ? "on" : "off";
    } catch (e) {
      return "Error occurred: ${e.toString()}";
    }
  }


  Future<void> onAttendanceVerify(String type, String identifier) async {
    final provider = context.read<DashboardProvider>();
    try {
      EasyLoading.show(
          status: translate('loader.requesting'), maskType: EasyLoadingMaskType.black);
      final response = await provider.verifyAttendanceApi(type, "", identifier: identifier);
      EasyLoading.dismiss();
      _showCustomDialog(response.message);
    } catch (e) {
      EasyLoading.dismiss();
      _showCustomDialog(e.toString());
    }
  }

  void _showCustomDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: CustomAlertDialog(message),
        );
      },
    );
  }

  Widget _buildDigitalClock() {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main clock displaying HH:mm
            DigitalClock(
              showSeconds: true,
              isLive: false,
              textScaleFactor: 2.2,
              format: "HH:mm",
              padding: const EdgeInsets.symmetric(vertical: 10),
              digitalClockTextColor: Colors.white,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              datetime: DateTime.now(),
            ),
            // Seconds and AM/PM display at the top-right corner
            Positioned(
              top: 10,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DigitalClock(
                    showSeconds: true,
                    isLive: false,
                    textScaleFactor: 0.9,
                    format: "ss",
                    padding: EdgeInsets.zero,
                    digitalClockTextColor: Colors.red,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    datetime: DateTime.now(),
                  ),
                  const SizedBox(height: 2), // Spacing between seconds and AM/PM
                  DigitalClock(
                    showSeconds: false,
                    isLive: false,
                    textScaleFactor: 0.9,
                    format: "a",
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    digitalClockTextColor: Colors.green,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    datetime: DateTime.now(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget _buildAttendanceButton(Map<String, dynamic> attendanceList, String attendanceType) {
    final isCheckedIn = attendanceList['check-in'] != "-" &&
        attendanceList['check-in'] != null &&
        attendanceList['check-out'] == "-" &&
        attendanceList['check-out'] != null;

    final buttonColor = HexColor(isCheckedIn ? "#e82e5f" : "#3b98cc").withOpacity(.5);

    return FutureBuilder<String>(
      future: checkLocation(37.4219983, -122.084, thresholdDistance: 95),
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator()); // Loading indicator
        // }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error message
        }

        // Determine animation asset based on location status
        final animationAsset = snapshot.data == "on"
            ? 'assets/raw/fingerprint.json'
            : 'assets/raw/nfc.json';

        print('hello ${snapshot.data}');
        // Build the button with the determined animation
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(90)),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: buttonColor,
            child: IconButton(
              iconSize: 70,
              onPressed: () => _showAttendanceBottomSheet(context),
              icon: Lottie.asset(
                animationAsset,
                width: 60,
                height: 60,
                repeat: true,
              ),
            ),
          ),
        );
      },
    );
  }


  void _showAttendanceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => const AttedanceBottomSheet(),
    );
  }


  @override
  Widget build(BuildContext context) {
    final attendanceList = context.watch<DashboardProvider>().attendanceList;
    final attendanceType = context.watch<PrefProvider>().attendanceType;
    final productionTime = attendanceList['production-time'] ?? 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDigitalClock(),
          const SizedBox(height: 5),
          Center(
            child: Text(
              formattedDate,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          _buildAttendanceButton(attendanceList, attendanceType),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 30.0,
              percent: productionTime,
              center: Text(
                attendanceList['production_hour'] ?? "00:00",
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
        ],
      ),
    );
  }
}
