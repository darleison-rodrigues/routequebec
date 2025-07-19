
import 'package:flutter/material.dart';
import 'package:routequebec/models/parking_result.dart';

class ResultsScreen extends StatelessWidget {
  final ParkingResult parkingResult;

  const ResultsScreen({super.key, required this.parkingResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Analysis'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              parkingResult.canPark ? 'You can park here!' : 'You cannot park here.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: parkingResult.canPark ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard('Confidence', '${(parkingResult.confidence * 100).toStringAsFixed(2)}%'),
            _buildInfoCard('Time Remaining', parkingResult.timeRemaining),
            _buildInfoCard('Restrictions', parkingResult.restrictions.type),
            _buildInfoCard('Max Duration', parkingResult.restrictions.maxDuration),
            _buildInfoCard('Valid Days', parkingResult.restrictions.validDays.join(', ')),
            _buildInfoCard('Valid Hours', '${parkingResult.restrictions.validHours['start']} - ${parkingResult.restrictions.validHours['end']}'),
            const SizedBox(height: 16),
            const Text(
              'Warnings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...parkingResult.warnings.map((warning) => Text('- $warning')),
            const SizedBox(height: 16),
            const Text(
              'Extracted Text',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('French: ${parkingResult.extractedText['french']}'),
            Text('English: ${parkingResult.extractedText['english']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
