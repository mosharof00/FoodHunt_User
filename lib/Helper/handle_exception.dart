// import 'package:supabase/supabase.dart';
// import 'package:food_hunt_user/Helper/logger.dart';
//
// class HandleException {
//   Future<T> fetchData<T>(Future<Response> Function() fetchFunction) async {
//     try {
//       // Call the fetch function provided by the caller
//       final response = await fetchFunction();
//
//       // Check for successful response
//       if (response.error != null) {
//         throw Exception('Error: ${response.error!.message}');
//       }
//
//       // Return the data (can be adapted based on your return type)
//       return response.data as T;
//     } catch (e) {
//       // Handle specific error types if needed
//       Log.e('Error fetching data: $e');
//       rethrow; // Rethrow to let the caller handle further if necessary
//     }
//   }
// }
