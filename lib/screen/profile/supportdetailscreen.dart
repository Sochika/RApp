import 'package:radius/model/support.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SupportDetailScreen extends StatelessWidget {
  Support support;

  SupportDetailScreen(this.support);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(translate('support_detail_screen.payslip')),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                elevation: 0,
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            support.query_date,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            support.status,
                            style: TextStyle(
                                color: support.status == "Pending"
                                    ? Colors.deepOrange
                                    : support.status == "In Progress"
                                    ? Colors.orangeAccent
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        support.title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                elevation: 0,
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate('support_detail_screen.description'),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.description,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate('support_detail_screen.assigned_to'),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.requested_department,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate('support_detail_screen.solved_by'),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.status != "Solved"?"-":support.solved_by,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate('support_detail_screen.solved_at'),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.status != "Solved"?"-":support.solved_at,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
