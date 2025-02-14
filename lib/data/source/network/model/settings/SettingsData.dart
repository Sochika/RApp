class SettingsData {
  final String staffRadius;
  final String viewOffBeats;
  final String whatsapp;
  final String phone;

  SettingsData({
    required this.staffRadius,
    required this.viewOffBeats,
    required this.whatsapp,
    required this.phone,
  });

  // Constructor that creates a SettingsData from JSON
  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      staffRadius: json['staff_radius'] as String? ?? '1000', // Default value
      viewOffBeats: json['view_off_beats'] as String? ?? '0',
      whatsapp: json['whatsapp'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
    );
  }

  // If you need to maintain the Map version for backward compatibility
  Map<String, dynamic> get settings => {
    'staff_radius': staffRadius,
    'view_off_beats': viewOffBeats,
    'whatsapp': whatsapp,
    'phone': phone,
  };

  // For serialization
  Map<String, dynamic> toJson() => settings;
}