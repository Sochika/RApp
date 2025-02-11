// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:radius/data/source/network/model/teamsheet/Employee.dart';
// import 'package:radius/provider/dashboardprovider.dart';
// import 'package:radius/screen/profile/employeedetailscreen.dart';
// import 'package:radius/screen/profile/teamsheetscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
//
// class MyTeam extends StatelessWidget {
//   const MyTeam({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final employee =
//         Provider.of<DashboardProvider>(context, listen: true);
//     return Visibility(
//       visible: employee.isNotEmpty,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   translate('home_screen.my_team'),
//                   style: const TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 const Spacer(),
//                 GestureDetector(
//                   onTap: () {
//                     Get.to(const TeamSheet(), arguments: {
//                       "department":
//                           context.read<DashboardProvider>().department,
//                       "branch": context.read<DashboardProvider>().branch
//                     });
//                   },
//                   child: Text(
//                     translate('home_screen.view_all'),
//                     style: const TextStyle(color: Colors.white, fontSize: 15),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               height: 100,
//               child: ListView.builder(
//                 physics: const PageScrollPhysics(),
//                 primary: false,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: employee.length,
//                 itemBuilder: (context, index) {
//                   return teamCard(employee[index]);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget teamCard(Employee teamList) {
//   return InkWell(
//     onTap: () {
//       Get.to(const EmployeeDetailScreen(),
//           arguments: {"employeeId": teamList.id.toString()});
//     },
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: SizedBox(
//         width: 80,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Card(
//               margin: EdgeInsets.zero,
//               shape: const CircleBorder(),
//               elevation: 0,
//               color: teamList.onlineStatus == "1"
//                   ? Colors.green
//                   : Colors.transparent,
//               child: Container(
//                 margin: const EdgeInsets.all(3.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(30),
//                   child: Container(
//                     color: Colors.white,
//                     child: CachedNetworkImage(
//                       imageUrl: teamList.avatar,
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Text(
//               teamList.first_name,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
