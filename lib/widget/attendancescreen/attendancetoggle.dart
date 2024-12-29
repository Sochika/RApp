import 'package:radius/model/month.dart';
import 'package:radius/provider/attendancereportprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class AttendanceToggle extends StatefulWidget {
  const AttendanceToggle({super.key});

  @override
  State<StatefulWidget> createState() => AttendanceToggleState();
}

class AttendanceToggleState extends State<AttendanceToggle> {
  var initial = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceReportProvider>(context,listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            translate('attendance_screen.attendance_history'),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Consumer(
            builder: (context, value, child) {
              return provider.month.isEmpty?const SizedBox.shrink(): DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: (provider.month)
                      .map((item) => DropdownMenuItem<Month>(
                    value: item,
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: provider.month[provider.selectedMonth],
                  onChanged: (value) {
                    print((value as Month).index);
                    setState(() {
                      provider.selectedMonth = (value).index;
                      provider.getAttendanceReport();
                    });
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 160,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10)),
                      color: HexColor("#FFFFFF"),
                    ),
                    elevation: 0,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: HexColor("#FFFFFF"),
                    ),
                    elevation: 8,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
