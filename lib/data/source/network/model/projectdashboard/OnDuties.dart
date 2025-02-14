class OnDuties {
  final Map<int, int> operativeBeatMap;

  OnDuties({required this.operativeBeatMap});

  factory OnDuties.fromJson(Map<String, dynamic> json) {
    final map = <int, int>{};
    json.forEach((key, value) {
      map[int.parse(key)] = value as int;
    });
    return OnDuties(operativeBeatMap: map);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    operativeBeatMap.forEach((key, value) {
      map[key.toString()] = value;
    });
    return map;
  }
}