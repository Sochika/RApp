import 'package:radius/data/source/network/model/teamsheet/Branch.dart';


class Data {
  Data({

    required this.shiftOperative,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(

      shiftOperative: (json['shiftOperative'] as List)
          .map((item) => ShiftOperative.fromJson(item))
          .toList(),
    );
  }

  final List<ShiftOperative> shiftOperative;

  Map<String, dynamic> toJson() {
    return {
      'shiftOperative': shiftOperative.map((item) => item.toJson()).toList(),
    };
  }
}
