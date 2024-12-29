class AllAward {
  String award_description;
  String award_name;
  String awarded_by;
  String awarded_date;
  String employee_name;
  String gift_description;
  String gift_item;
  int id;
  String image;
  String reward_code;

  AllAward(
      {required this.award_description,
      required this.award_name,
      required this.awarded_by,
      required this.awarded_date,
      required this.employee_name,
      required this.gift_description,
      required this.gift_item,
      required this.id,
      required this.image,
      required this.reward_code});

  factory AllAward.fromJson(Map<String, dynamic> json) {
    return AllAward(
      award_description: json['award_description'],
      award_name: json['award_name'],
      awarded_by: json['awarded_by'],
      awarded_date: json['awarded_date'],
      employee_name: json['employee_name'],
      gift_description: json['gift_description'],
      gift_item: json['gift_item'],
      id: json['id'],
      image: json['employee_image'],
      reward_code: json['reward_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['award_description'] = award_description;
    data['award_name'] = award_name;
    data['awarded_by'] = awarded_by;
    data['awarded_date'] = awarded_date;
    data['employee_name'] = employee_name;
    data['gift_description'] = gift_description;
    data['gift_item'] = gift_item;
    data['id'] = id;
    data['image'] = image;
    data['reward_code'] = reward_code;
    return data;
  }
}
