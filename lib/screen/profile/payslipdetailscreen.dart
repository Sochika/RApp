import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:radius/provider/payslipdetailprovider.dart';
import 'package:radius/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PaySlipDetailScreen extends StatefulWidget {
  static const String routeName = "/paySlipDetail";
  bool initial = true;
  int payslipId = 0;

  PaySlipDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() => PaySlipScreenState();
}

class PaySlipScreenState extends State<PaySlipDetailScreen> {
  @override
  void didChangeDependencies() {
    if (widget.initial) {
      widget.initial = false;
      getPaySlipDetail();
    }
    super.didChangeDependencies();
  }

  Future<void> getPaySlipDetail() async {
    EasyLoading.show(status: translate('loader.loading'), maskType: EasyLoadingMaskType.black);
    widget.payslipId = ModalRoute.of(context)!.settings.arguments as int;
    await context
        .read<PaySlipDetailProvider>()
        .getPaySlipData(widget.payslipId.toString());
    EasyLoading.dismiss(animation: true);
  }

  @override
  Widget build(BuildContext context) {
    String? generatedPdfFilePath;

    final flutterNativeHtmlToPdfPlugin = FlutterNativeHtmlToPdf();

    Future<void> generateExampleDocument() async {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final targetPath = appDocDir.path;
      var targetFileName =
          context.read<PaySlipDetailProvider>().payslipDetail["salary_title"]!;
      final generatedPdfFile =
          await flutterNativeHtmlToPdfPlugin.convertHtmlToPdf(
        html: context.read<PaySlipDetailProvider>().payslipDetail["pdf_raw"] ??
            "",
        targetDirectory: targetPath,
        targetName: targetFileName,
      );

      await Share.shareXFiles(
        [XFile(generatedPdfFile!.path)],
        text: context
            .read<PaySlipDetailProvider>()
            .payslipDetail["salary_title"]!,
      );
    }

    final provider = Provider.of<PaySlipDetailProvider>(context);
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('${provider.payslipDetail["payslip_slug"]}'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  generateExampleDocument();
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                ))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await getPaySlipDetail();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: provider.payslipDetail["company_image"]!,
                      color: Colors.white,
                      width: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.payslipDetail["company_name"]!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          provider.payslipDetail["company_address"]!,
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          provider.payslipDetail["salary_title"]!,
                          style: const TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${translate('payslipdetail_screen.emp_id')} : ${provider.payslipDetail["employee_code"]!}',
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        provider.payslipDetail["employee_name"]!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        provider.payslipDetail["employee_designation"]!,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        '${translate('payslipdetail_screen.joining_date')} : ${provider.payslipDetail["employee_join_date"]}',
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: provider.earningList.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Divider(color: Colors.white54,indent: 0,endIndent: 0,),
                        ),
                        Text(
                          translate('payslipdetail_screen.earnings'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                          color: Colors.white24,
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.earningList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                tileColor: Colors.transparent,
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                title: Text(
                                  provider.earningList[index].name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                trailing: Text(
                                    '${provider.currency}. ${provider.earningList[index].amount}',
                                    style: const TextStyle(
                                      fontFamily: "",
                                        color: Colors.white, fontSize: 15)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: provider.deductionList.isNotEmpty,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          translate('payslipdetail_screen.deductions'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 0,
                          color: Colors.white24,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                          child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.deductionList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                tileColor: Colors.transparent,
                                visualDensity: VisualDensity.compact,
                                dense: true,
                                title: Text(
                                  provider.deductionList[index].name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                trailing: Text(
                                    '${provider.currency} ${provider.deductionList[index].amount}',
                                    style: const TextStyle(
                                        fontFamily: "",
                                        color: Colors.white, fontSize: 15)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        tileColor: Colors.transparent,
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        title: Text(
                          translate('payslipdetail_screen.actual_salary'),
                          style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                            '${provider.currency}. ${provider.getTotalEarning() - provider.getTotalDeduction()}',
                            style: const TextStyle(
                                fontFamily: "",color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold)),
                      ),
                      const Divider(color: Colors.white54,indent: 10,endIndent: 10,),
                      ListTile(
                        tileColor: Colors.transparent,
                        visualDensity: VisualDensity.compact,
                        dense: true,
                        title: Text(
                          translate('payslipdetail_screen.absent_deduction'),
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        trailing: Text(
                            '${provider.currency}. ${provider.payslipDetail["absent_deduction"]}',
                            style: const TextStyle(
                                fontFamily: "",color: Colors.red, fontSize: 15)),
                      ),
                      Visibility(
                        visible:
                            provider.payslipDetail["advance_salary"] != "0.00",
                        child: ListTile(
                          tileColor: Colors.transparent,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          title: Text(
                            translate('payslipdetail_screen.advance_salary'),
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          trailing: Text(
                              '${provider.currency}. ${provider.payslipDetail["advance_salary"]}',
                              style:
                                  const TextStyle(
                                      fontFamily: "",color: Colors.red, fontSize: 15)),
                        ),
                      ),
                      Visibility(
                        visible: provider.payslipDetail["tada"] != "0.00",
                        child: ListTile(
                          tileColor: Colors.transparent,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          title: Text(
                            translate('payslipdetail_screen.tada'),
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          trailing: Text(
                              '${provider.currency}. ${provider.payslipDetail["tada"]}',
                              style:
                                  const TextStyle(
                                      fontFamily: "",color: Colors.green, fontSize: 15)),
                        ),
                      ),
                      Visibility(
                        visible: provider.payslipDetail["overtime"] != "0.00",
                        child: ListTile(
                          tileColor: Colors.transparent,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          title: Text(
                            translate('payslipdetail_screen.overtime'),
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          trailing: Text(
                              '${provider.currency}. ${provider.payslipDetail["overtime"]}',
                              style:
                                  const TextStyle(
                                      fontFamily: "",color: Colors.green, fontSize: 15)),
                        ),
                      ),
                      Visibility(
                        visible: provider.payslipDetail["undertime"] != "0.00",
                        child: ListTile(
                          tileColor: Colors.transparent,
                          visualDensity: VisualDensity.compact,
                          dense: true,
                          title: Text(
                            translate('payslipdetail_screen.undertime'),
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          trailing: Text(
                              '${provider.currency}. ${provider.payslipDetail["undertime"]}',
                              style:
                                  const TextStyle(
                                      fontFamily: "",color: Colors.red, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                    color: Colors.white24,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate('payslipdetail_screen.net_salary'),
                            style: const TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                                style:
                                    const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),
                                text:
                                    '${provider.currency} ${provider.payslipDetail["net_salary"]}',
                                children: [
                                  TextSpan(
                                    text:
                                        "  (${provider.payslipDetail["net_salary_in_words"]!})",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12,fontWeight: FontWeight.normal),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
