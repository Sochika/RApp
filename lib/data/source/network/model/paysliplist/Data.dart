import 'package:radius/data/source/network/model/paysliplist/Payslip.dart';

class Data {
    String currency;
    List<Payslip> payslip;

    Data({required this.currency,required this.payslip});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            currency: json['currency'], 
            payslip: (json['payslip'] as List).map((i) => Payslip.fromJson(i)).toList(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['currency'] = currency;
          data['payslip'] = payslip.map((v) => v.toJson()).toList();
              return data;
    }
}