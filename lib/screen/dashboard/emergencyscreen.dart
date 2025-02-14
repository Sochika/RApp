import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:gif_view/gif_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:http/http.dart' as http;

import '../../provider/settingsprovider.dart';
import '../../utils/ContactButtons.dart';
import '../../widget/headerprofile.dart';
import '../../widget/radialDecoration.dart';

class Emergencyscreen extends StatefulWidget {
  const Emergencyscreen({super.key});

  @override
  State<Emergencyscreen> createState() => _EmergencyscreenState();
}

class _EmergencyscreenState extends State<Emergencyscreen> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    try {
      final settingsProvider =
          Provider.of<SettingsProvider>(context, listen: false);
      await settingsProvider.fetchSettings();
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _errorMessage = 'Failed to load data: ${e.toString()}');
    }
  }

  Widget _buildContactButtons() {
    return Consumer<SettingsProvider>(builder: (context, provider, _) {
      final settings = provider.settings;
      print(provider.settings?.data.settings.values);
      return ContactButtons(
        whatsappNumber: settings?.data.whatsapp?? '',
        callNumber: settings?.data.phone ?? '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FocusDetector(
          onVisibilityGained: _loadData,
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: _loadData,
              child: Column(
                children: [
                  const HeaderProfile(),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const SizedBox(height: 52),
                        _buildEmergencyGif(context),
                        const SizedBox(height: 52),
                        _buildContactButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _EmergencyscreenState extends State<Emergencyscreen> {
//   late final SettingsProvider _settingsProvider;
//   // late final AttendanceReportProvider _attendanceProvider;
//   bool _isLoading = true;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeProviders();
//   }
//
//   void _initializeProviders() {
//     _settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
//     // _attendanceProvider = Provider.of<AttendanceReportProvider>(context, listen: false);
//   }
//
//   Future<void> _loadData() async {
//     try {
//       await Future.wait([
//         _settingsProvider.fetchSettings(),
//         // _attendanceProvider.getDate(),
//       ]);
//       setState(() => _isLoading = false);
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load data: ${e.toString()}');
//     }
//   }
//
//   Widget _buildBody() {
//     if (_errorMessage != null) {
//       return Center(child: Text(_errorMessage!));
//     }
//
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return SingleChildScrollView(
//       physics: const AlwaysScrollableScrollPhysics(),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const HeaderProfile(),
//             const SizedBox(height: 52),
//             _buildEmergencyGif(),
//             const SizedBox(height: 52),
//             _buildContactButtons(),
//           ],
//         ),
//       ),
//     );
//   }
//
  Widget _buildEmergencyGif(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GifView.asset(
      'assets/icons/logo.gif',
      width: screenSize.width * 0.8,
      height: screenSize.height * 0.4,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }
//
//   Widget _buildContactButtons() {
//     final settings = _settingsProvider.settings;
//     return ContactButtons(
//       whatsappNumber: settings?.data.settings['whatsapp']  ?? '',
//       callNumber: settings?.data.settings['phone'] ?? '',
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: RadialDecoration(),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: FocusDetector(
//           onVisibilityGained: _loadData,
//           child: SafeArea(
//             child: RefreshIndicator(
//               onRefresh: _loadData,
//               child: _buildBody(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
