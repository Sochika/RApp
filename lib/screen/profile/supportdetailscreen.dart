import 'package:radius/model/support.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SupportDetailScreen extends StatelessWidget {
  Support support;

  SupportDetailScreen(this.support, {super.key});

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
              padding: const EdgeInsets.all(10),
              child: Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
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
                            style: const TextStyle(color: Colors.white, fontSize: 14),
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

                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        support.title,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                elevation: 0,
                color: Colors.white24,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate('support_detail_screen.description'),
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.description,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate('support_detail_screen.assigned_to'),
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.requested_department,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate('support_detail_screen.solved_by'),
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.status != "Solved"?"-":support.solved_by,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        translate('support_detail_screen.solved_at'),
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.status != "Solved"?"-":support.solved_at,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
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
