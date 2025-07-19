import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routequebec/models/parking_result.dart';
import 'package:routequebec/screens/results_screen.dart';
import 'package:routequebec/services/api_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();
  final ApiService _apiService = ApiService();

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      // Show a loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      final ParkingResult? result = await _apiService.analyzeImage(photo);

      // Hide the loading indicator
      Navigator.of(context).pop();

      if (result != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultsScreen(parkingResult: result),
          ),
        );
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to analyze image.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _takePhoto,
        child: const Text('Take Photo'),
      ),
    );
  }
}