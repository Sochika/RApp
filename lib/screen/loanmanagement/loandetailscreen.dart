import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoanDetailScreen extends StatelessWidget {
  const LoanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(translate('loan_detail_screen.loan_detail')),
            ),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Row(
                  children: [
                    Card(
                      elevation: 0,
                      color: "pending" == "pending"
                          ? Colors.orange.shade500
                          : "pending" == "rejected"
                              ? Colors.red.shade500
                              : Colors.green.shade500,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Pending",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${translate('edit_loan_screen.total')} ",
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    const Text("Rs " "50000",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "24 June 2024",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      translate('edit_loan_screen.requested_amount'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "800000",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      translate('edit_loan_screen.granted_amount'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "55000",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      translate('edit_loan_screen.interest_rate'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "10%",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      translate('edit_loan_screen.installment_period'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "12 months",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      translate('edit_loan_screen.is_settled'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      translate('edit_loan_screen.loan_detail'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sodales ipsum faucibus imperdiet sodales. Praesent aliquet, magna sed ullamcorper finibus.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      translate('edit_loan_screen.verified_by'),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "Loard Benter",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "translate('edit_loan_screen.remarks')",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sodales ipsum faucibus imperdiet sodales. Praesent aliquet, magna sed ullamcorper finibus.",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
          ),
        ),
    );
  }
}
