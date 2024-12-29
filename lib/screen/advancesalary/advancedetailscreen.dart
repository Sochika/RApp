import 'package:radius/provider/advancedetailcontroller.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class AdvanceDetailScreen extends StatelessWidget {
  const AdvanceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(AdvanceDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Obx(
        () => SafeArea(
          child: model.isLoading.value
              ? const SizedBox.shrink()
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title:
                        Text(translate('advance_detail_screen.advance_detail')),
                  ),
                  bottomNavigationBar: Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      child: Row(
                        children: [
                          Card(
                            elevation: 0,
                            color: model.advanceSalary.value.status
                                        .toLowerCase() ==
                                    "pending"
                                ? Colors.orange.shade500
                                : model.advanceSalary.value.status
                                            .toLowerCase() ==
                                        "rejected"
                                    ? Colors.red.shade500
                                    : Colors.green.shade500,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(model.advanceSalary.value.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${translate('advance_detail_screen.total')} ",
                            style: const TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          Text(
                              "${translate('advance_detail_screen.rs')} ${model.advanceSalary.value.released_amount}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                  body: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerRight,
                            child: Text(
                              model.advanceSalary.value.submittedDate,
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            translate('advance_detail_screen.requested_amount'),
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            model.advanceSalary.value.requested_amount,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            translate('advance_detail_screen.released_amount'),
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            model.advanceSalary.value.released_amount,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            translate('advance_detail_screen.is_settled'),
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            !model.advanceSalary.value.is_settled
                                ? translate('advance_detail_screen.no')
                                : translate('advance_detail_screen.yes'),
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            translate('advance_detail_screen.reason'),
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            parse(model.advanceSalary.value.description ?? "")
                                .body!
                                .text,
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            translate('advance_detail_screen.verified_by'),
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            parse(model.advanceSalary.value.verifiedBy ?? "N/A")
                                .body!
                                .text,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            translate('advance_detail_screen.remarks'),
                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          Text(
                            parse(model.advanceSalary.value.remark ?? "N/A")
                                .body!
                                .text,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
