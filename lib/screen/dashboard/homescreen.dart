import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:radius/data/source/datastore/preferences.dart';
import 'package:radius/data/source/network/model/dashboard/BeatBranch.dart';
import 'package:radius/data/source/network/model/dashboard/Dashboardresponse.dart';
import 'package:radius/data/source/network/model/dashboard/UserAttend.dart';
import 'package:radius/data/source/network/model/login/User.dart';
import 'package:radius/provider/dashboardprovider.dart';
import 'package:radius/provider/locationoperativeprovider.dart';
import 'package:radius/provider/prefprovider.dart';
import 'package:radius/screen/general/generalscreen.dart';
import 'package:radius/utils/constant.dart';

import 'package:radius/widget/customalertdialog.dart';
import 'package:radius/widget/homescreen/checkattendance.dart';

import 'package:radius/widget/homescreen/overviewdashboard.dart';
import 'package:radius/widget/homescreen/recentAward.dart';
import 'package:radius/widget/homescreen/upcomingholiday.dart';

import 'package:radius/widget/radialDecoration.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';
import 'package:radius/widget/headerprofile.dart';
import 'package:quick_actions/quick_actions.dart';
import '../../utils/AlarmScreen.dart';
import '../../utils/LocationService.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class HomeScreen extends StatefulWidget {
  PersistentTabController controller;

  HomeScreen(this.controller, {super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState(controller);
}

class HomeScreenState extends State<HomeScreen> {
  QuickActions quickActions = const QuickActions();
  final LocationService _locationService = LocationService();
  bool isEnabled = true;
  bool isLoading = false;
  double? userLatitude;
  double? userLongitude;
  Position? position;
  String? address ='No address found';
  BeatBranch? beat;
  UserAttend? shiftTime;
  Dashboardresponse? beatNo;
  Timer? locationTimer;

  PersistentTabController controller;

  HomeScreenState(this.controller);

  @override
  void initState() {
    super.initState();

    locationStatus();
    checkNotificationState();
    // getPositionStream();
    _initializeLocation();

    // Ensure loadDashboard is called after the first frame to avoid context-related issues
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDashboard(context);
    });

    // void startLocationUpdates() {
    //   locationTimer?.cancel(); // Cancel any existing timer
    //
    //   if (beatNo?.data.onDuties.operativeBeatMap[beatNo?.data.user.userId ?? 0] != null) {
    //     locationTimer = Timer.periodic(const Duration(seconds: 1200), (timer) {
    //       locationUpdate();
    //     });
    //   }
    // }

    quickActions.initialize((type) async {
      if (type == "actionCheckIn") {
        await onCheckInShortCut();
      } else if (type == "actionCheckOut") {
        await onCheckOutShortCut();
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
          type: 'actionCheckIn', localizedTitle: 'Check In', icon: 'check_in'),
      const ShortcutItem(
          type: 'actionCheckOut', localizedTitle: 'Check Out', icon: 'check_out'),
    ]);
  }

  void checkNotificationState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      // print("FirebaseMessaging.getInitialMessage $message");
      if (message == null) {
        return;
      }
      Get.to(GeneralScreen(), arguments: {
        "title": message.data["title"],
        "message": message.data["message"],
        "date": ""
      });
    });
  }

  void locationStatus() async {

    try {
      // Preferences preferences = Preferences();
      // final position = await LocationStatus()
      //     .determinePosition(await preferences.getWorkSpace());

      if (!mounted) {
        return;
      }
      final location =
          Provider.of<DashboardProvider>(context, listen: false).locationStatus;

      location.update('latitude', (value) => position?.latitude ?? 0.0);
      location.update('longitude', (value) => position?.longitude ?? 0.0);

    } catch (e) {
      // print(e);
      showToast(e.toString());
    }
  }

  void locationUpdate() async {

    try {
      // Preferences preferences = Preferences();
      // final position = await LocationStatus()
      //     .determinePosition(await preferences.getWorkSpace());

      if (!mounted) {
        return;
      }
      await Provider.of<LocationOperativeProvider>(context, listen: false)
          .locationUpdate(
          userLatitude as String,
          userLongitude as String,
          address!);
    } catch (e) {
      // print(e);
      showToast(e.toString());
    }
  }



  Future<void> onCheckInShortCut() async {
    Preferences pref = Preferences();
    if ((await pref.getToken()).isNotEmpty) {
      if ((await pref.getUserAuth())) {
        return;
      }
      final provider = Provider.of<DashboardProvider>(context, listen: false);

      try {
        isLoading = true;
        setState(() {
          EasyLoading.show(
              status: translate('loader.requesting'), maskType: EasyLoadingMaskType.black);
        });
        var status = await provider.getCheckInStatus();
        if (status) {
          final response = await provider.checkInAttendance();
          isEnabled = true;
          if (!mounted) {
            return;
          }
          setState(() {
            EasyLoading.dismiss(animation: true);
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: CustomAlertDialog(response.message),
                );
              },
            );
          });
        }
      } catch (e) {
        // print(e);
        setState(() {
          EasyLoading.dismiss(animation: true);
          isLoading = false;
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
    } else {
      showToast("Please Login First");
    }
  }

  Future<void> onCheckOutShortCut() async {
    Preferences pref = Preferences();
    if ((await pref.getToken()).isNotEmpty) {
      if ((await pref.getUserAuth())) {
        return;
      }
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      try {
        isLoading = true;
        setState(() {
          EasyLoading.show(
              status: "Requesting...", maskType: EasyLoadingMaskType.black);
        });
        var status = await provider.getCheckInStatus();
        if (status) {
          final response = await provider.checkOutAttendance();
          isEnabled = true;
          if (!mounted) {
            return;
          }
          setState(() {
            EasyLoading.dismiss(animation: true);
            isLoading = false;
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: CustomAlertDialog(response.message),
                );
              },
            );
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          EasyLoading.dismiss(animation: true);
          isLoading = false;
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
    } else {
      showToast("Please Login First");
    }
  }

  Future<Dashboardresponse?> fetchDashboard(BuildContext context) async {
    try {
      // Check internet connectivity
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        if (!context.mounted) return null; // Ensure context is still valid

        // Show no internet dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your internet connection and try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );

        return null; // Stop further execution
      }

      // Fetch dashboard data
      return await Provider.of<DashboardProvider>(context, listen: false).getDashboard();
    } catch (e) {
      debugPrint("Error fetching dashboard: $e");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to Connect to Internet. Please try again.')),
        );
      }
      return null;
    }
  }


  Future<String> loadDashboard(BuildContext context) async {
    try {
      final dashboardResponse = await fetchDashboard(context);

      // Check if the response is null (e.g., no internet)
      if (dashboardResponse == null) {
        return 'error'; // Handle it properly instead of crashing
      }

      final user = dashboardResponse.data.user;
      print('hello $user' );

      // Safely parse latitude & longitude
      userLatitude = double.tryParse(dashboardResponse.data.userAttend.beatBranch.latitude);
      userLongitude = double.tryParse(dashboardResponse.data.userAttend.beatBranch.longitude);
      // print(dashboardResponse.data.shifts.lastOrNull);

      if (mounted) {
        setState(() {
          shiftTime = dashboardResponse.data.userAttend;
          beat = dashboardResponse.data.userAttend.beatBranch;
          beatNo = dashboardResponse;
        });
      }

      // Save user details using Provider
      Provider.of<PrefProvider>(context, listen: false).saveBasicUser(User(
        id: user.userId,
        firstName: user.staff.firstName,
        lastName: user.staff.lastName,
        avatar: user.staff.avatar,
        gender: user.staff.gender,
        staffNo: user.staff.staff_no,
        hireDate: user.staff.hire_date,
        dob: user.staff.dob,
      ));

      // Show birthday wish if it's the user's birthday
      if (checkIfBirthday(user.staff.dob ?? '')) {
        showBirthdayWish();
      }

      return 'loaded';
    } catch (e) {
      print('Error loading dashboard: $e');
      return 'error';
    }
  }


  bool checkIfBirthday(String dob) {
    try {
      if (dob.isEmpty) return false;
      final DateTime dobDate = DateFormat('yyyy-MM-dd').parse(dob);
      final DateTime today = DateTime.now();
      return dobDate.day == today.day && dobDate.month == today.month;
    } catch (e) {
      print("Error parsing birthday: $e");
      return false;
    }
  }
  void showBirthdayWish() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/raw/hbd.json'),
                  Lottie.asset('assets/raw/hbd_text.json'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FocusDetector(
          onFocusGained: () {
            loadDashboard(context);
          },
          child: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            edgeOffset: 50,
            onRefresh: () {
              _initializeLocation();
              // getPositionStream();
              return loadDashboard(context);
            },
            child: SafeArea(
                child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HeaderProfile(),
                    CheckAttendance(latitude: userLatitude ?? 0.00, longitude: userLongitude ?? 0.00, Beat:  beat ?? BeatBranch(beatBranchId: 0, name: 'the designated area', area: '', latitude: '', longitude: '') , position: position ?? Position(latitude: 0.0, longitude: 0.0, timestamp: DateTime(11,1,1), accuracy: 0.0, altitude: 0.0, altitudeAccuracy: 0.0, heading: 0.0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0),),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Location: ${address ?? 'Fetching address...'}',
                        style: const TextStyle(color: Colors.white),
                        selectionColor: Colors.white,
                      ),
                    ),

                    OverviewDashboard(controller, beatNo),
                    const UpcomingHoliday(),
                    const RecentAward(),
                    AlarmScreen(
                      timeIn: shiftTime?.shiftStart ?? '00:00', // Default fallback time
                      timeOut: shiftTime?.shiftEnd ?? '00:00',
                    ),

                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }


  Future<void> _initializeLocation() async {
    const maxRetries = 3;
    int attempt = 0;
    bool success = false;

    setState(() => address = 'Locating...');

    while (attempt < maxRetries && !success) {
      try {
        // Get position with timeout
        position = await _locationService.getCurrentPosition()
            .timeout(const Duration(seconds: 10));

        // Geocoding with retryable request
        final placemarks = await _getPlacemarksWithRetry(
          position!.latitude,
          position!.longitude,
        );

        if (placemarks.isNotEmpty) {
          _updateAddress(placemarks.first);
          success = true;
        } else {
          setState(() => address = 'Address not found');
        }
      } on TimeoutException {
        setState(() => address = 'Location timeout - retrying...');
        attempt++;
        await Future.delayed(Duration(seconds: attempt * 2));
      } on PlatformException catch (e) {
        _handleGeocodingError(e);
        break;
      } catch (e) {
        setState(() => address = 'Location error');
        print("Location Error: $e");
        break;
      }
    }

    if (!success && mounted) {
      setState(() => address = 'Failed after $maxRetries attempts');
    }
  }

  Future<List<Placemark>> _getPlacemarksWithRetry(double lat, double lng) async {
    for (int i = 0; i < 3; i++) {
      try {
        return await placemarkFromCoordinates(lat, lng)
            .timeout(Duration(seconds: (i + 1) * 5));
      } on TimeoutException {
        print("Geocoding attempt ${i + 1} timed out");
        if (i == 2) rethrow;
      }
    }
    return [];
  }


  void _updateAddress(Placemark place) {
    final addressParts = [
      if (place.street?.isNotEmpty ?? false) place.street,
      if (place.locality?.isNotEmpty ?? false) place.locality,
      if (place.administrativeArea?.isNotEmpty ?? false) place.administrativeArea,
      if (place.country?.isNotEmpty ?? false) place.country,
    ].whereType<String>().toList();

    if (mounted) {
      setState(() => address = addressParts.isEmpty
          ? 'Address unavailable'
          : addressParts.join(', '));
    }
  }

  void _handleGeocodingError(PlatformException e) {
    if (!mounted) return;
    setState(() {
      address = switch (e.code) {
        'PERMISSION_DENIED' => 'Location permission denied. Enable in settings.',
        'IO_ERROR' => 'Network error - check connection',
      // ... existing cases
        _ => 'Location service error',
      };
    });
  }


  void showLoader() {
    setState(() {
      EasyLoading.show(
          status: "Logging Out, Please Wait..",
          maskType: EasyLoadingMaskType.black);
    });
  }

  void stopLocationUpdates() {
    locationTimer?.cancel();
  }
  // Future<Position?> getCurrentLocation() async {
  //   try {
  //     LocationPermission permission = await Geolocator.checkPermission();
  //
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         print("Location permission denied.");
  //         return null;
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       print("Location permission is permanently denied.");
  //       return null;
  //     }
  //
  //     Position positiona = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //
  //     // Reverse geocode to get the address
  //     List<Placemark> placemarks = await placemarkFromCoordinates(positiona.latitude, positiona.longitude);
  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;
  //       setState(() {
  //         position = positiona;
  //         address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //       });
  //     } else {
  //       setState(() {
  //         address = 'No address found';
  //       });
  //     }
  //
  //     return position;
  //   } catch (e) {
  //     print("Error occurred while getting location: ${e.toString()}");
  //     return null;
  //   }
  // }

  // Future<void> getPositionStream() async {
  //   try {
  //     LocationPermission permission = await Geolocator.checkPermission();
  //
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         print("Location permission denied.");
  //         return;
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       print("Location permission is permanently denied.");
  //       return;
  //     }
  //
  //     // Start listening to location updates using getPositionStream
  //     Geolocator.getPositionStream(
  //       // desiredAccuracy: LocationAccuracy.high,
  //       // distanceFilter: 10, // Minimum distance (in meters) to trigger updates
  //     ).listen((Position positiona) async {
  //       // Reverse geocode to get the address for the new position
  //       List<Placemark> placemarks = await placemarkFromCoordinates(positiona.latitude, positiona.longitude);
  //       if (placemarks.isNotEmpty) {
  //         Placemark place = placemarks.first;
  //         setState(() {
  //           position = positiona;  // Update the position with the latest location
  //           address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  //         });
  //       } else {
  //         setState(() {
  //           address = 'No address found';
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     print("Error occurred while getting location: ${e.toString()}");
  //   }
  // }


}
