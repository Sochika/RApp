import 'package:radius/widget/buttonborder.dart';
import 'package:flutter/material.dart';

class AttendanceCardView extends StatelessWidget{
  final int index;
  final String date;
  final String day;
  final String workedHr;
  final String start;
  final String end;

  const AttendanceCardView(this.index, this.date, this.day, this.start, this.end,this.workedHr, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white12,
      shape: ButtonBorder(),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(date,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.start),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(day,
                      style: const TextStyle(fontSize: 15, color: Colors.white70),
                      textAlign: TextAlign.start),
                ),
              ),
              Expanded(
                flex: 2,
                  child: Container(
                    child: Text(start,
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(end,
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.right),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(workedHr,
                        style: const TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.normal),
                        textAlign: TextAlign.end),
                  )),
            ],
          )),
    );
  }

}