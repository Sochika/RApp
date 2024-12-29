class Payslip {
  String absent_days;
  String duration;
  String holidays;
  int id;
  String leave_days;
  String net_salary;
  String payslip_id;
  String present_days;
  String salary_cycle;
  String salary_from;
  String salary_to;
  String total_days;
  String weekends;

  Payslip(
      {required this.absent_days,
      required this.duration,
      required this.holidays,
      required this.id,
      required this.leave_days,
      required this.net_salary,
      required this.payslip_id,
      required this.present_days,
      required this.salary_cycle,
      required this.salary_from,
      required this.salary_to,
      required this.total_days,
      required this.weekends});

  factory Payslip.fromJson(Map<String, dynamic> json) {
    return Payslip(
      absent_days: json['absent_days'].toString(),
      duration: json['duration'].toString(),
      holidays: json['holidays'].toString(),
      id: json['id'],
      leave_days: json['leave_days'].toString(),
      net_salary: json['net_salary'].toString(),
      payslip_id: json['payslip_id'].toString(),
      present_days: json['present_days'].toString(),
      salary_cycle: json['salary_cycle'].toString(),
      salary_from: json['salary_from'].toString(),
      salary_to: json['salary_to'].toString(),
      total_days: json['total_days'].toString(),
      weekends: json['weekends'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['absent_days'] = absent_days;
    data['duration'] = duration;
    data['holidays'] = holidays;
    data['id'] = id;
    data['leave_days'] = leave_days;
    data['net_salary'] = net_salary;
    data['payslip_id'] = payslip_id;
    data['present_days'] = present_days;
    data['salary_cycle'] = salary_cycle;
    data['salary_from'] = salary_from;
    data['salary_to'] = salary_to;
    data['total_days'] = total_days;
    data['weekends'] = weekends;
    return data;
  }
}
