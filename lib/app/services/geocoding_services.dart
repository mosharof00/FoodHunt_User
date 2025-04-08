import 'package:dio/dio.dart';

import '../../appConfig.dart';

class GooglePlacesService {
  final Dio _dio = Dio();
  final String apiKey =
      AppConfig.GOOGLE_API_KEY; // Replace with your Google API Key

  // Function to get coordinates using Google Places API
  Future<Map<String, double>?> getCoordinatesFromPlace(String address) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=${Uri.encodeComponent(address)}&key=$apiKey';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['results'] != null && data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          return {
            'latitude': location['lat'],
            'longitude': location['lng'],
          };
        } else {
          throw Exception('No results found for the provided address');
        }
      } else {
        throw Exception('Failed to fetch coordinates: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching coordinates: $e');
    }
  }
}
