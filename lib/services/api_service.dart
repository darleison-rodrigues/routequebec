
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:routequebec/models/parking_result.dart';

class ApiService {
  final String _apiUrl = 'https://your-worker.your-subdomain.workers.dev/analyze'; // Replace with your actual API URL

  Future<ParkingResult?> analyzeImage(XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ParkingResult.fromJson(jsonResponse);
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Exception: $e');
      return null;
    }
  }
}
