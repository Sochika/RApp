class Mentioned{
  String id;
  String name;

  Mentioned({required this.id,required this.name});

  factory Mentioned.fromJson(Map<String, dynamic> json) {
    return Mentioned(
      id: json['id'].toString(),
      name: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}