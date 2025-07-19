
import 'package:routequebec/models/parking_restriction.dart';

class ParkingResult {
  final bool canPark;
  final double confidence;
  final ParkingRestriction restrictions;
  final String timeRemaining;
  final List<String> warnings;
  final Map<String, String> extractedText;

  ParkingResult({
    required this.canPark,
    required this.confidence,
    required this.restrictions,
    required this.timeRemaining,
    required this.warnings,
    required this.extractedText,
  });

  factory ParkingResult.fromJson(Map<String, dynamic> json) {
    return ParkingResult(
      canPark: json['result']['canPark'] ?? false,
      confidence: (json['result']['confidence'] ?? 0.0).toDouble(),
      restrictions: ParkingRestriction.fromJson(json['result']['restrictions'] ?? {}),
      timeRemaining: json['result']['timeRemaining'] ?? 'N/A',
      warnings: List<String>.from(json['result']['warnings'] ?? []),
      extractedText: Map<String, String>.from(json['result']['extractedText'] ?? {}),
    );
  }
}
