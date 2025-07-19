
class ParkingRestriction {
  final String type;
  final String maxDuration;
  final List<String> validDays;
  final Map<String, String> validHours;

  ParkingRestriction({
    required this.type,
    required this.maxDuration,
    required this.validDays,
    required this.validHours,
  });

  factory ParkingRestriction.fromJson(Map<String, dynamic> json) {
    return ParkingRestriction(
      type: json['type'] ?? 'N/A',
      maxDuration: json['maxDuration'] ?? 'N/A',
      validDays: List<String>.from(json['validDays'] ?? []),
      validHours: Map<String, String>.from(json['validHours'] ?? {}),
    );
  }
}
