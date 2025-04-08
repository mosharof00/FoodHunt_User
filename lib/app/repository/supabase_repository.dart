import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:food_hunt_user/Helper/logger.dart';


class SupabaseRepository {
  final SupabaseClient _client;

  SupabaseRepository() : _client = Supabase.instance.client;

  // Function to sign up a user
  Future<User?> signUp(String email, String password, String role) async {
    try {
      final response = await _client.auth
          .signUp(email: email, password: password, data: {'role': role});
      return response.user;
    } catch (e) {
      throw Exception('Error signing up: $e');
    }
  }

  // Function to sign in a user
  Future<User?> signIn(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user;
    } on AuthApiException catch (e) {
      Log.e(e);
      throw e.message;
    }
  }

  // Function to log out a user
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  // Function to fetch data from a table
  Future<List<dynamic>> fetchData(String tableName) async {
    try {
      final response = await _client.from(tableName).select();
      return response;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Function to fetch data from a table with a filter
  Future<List<dynamic>> fetchDataWithFilter(
      {required String tableName,
      required String column,
      required String value}) async {
    try {
      final response = await _client.from(tableName).select().eq(column, value);
      return response;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Function to fetch data from a table with a filter
  Future<List<dynamic>> fetchDataWithFilter2(
      {required String tableName,
      required String column1,
      required String value1,
      required String column2,
      required dynamic value2}) async {
    try {
      final response = await _client
          .from(tableName)
          .select()
          .eq(column1, value1)
          .eq(column2, value2);
      return response;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Function to fetch data from a table with a filter return object
  Future<Map<String, dynamic>> fetchDataWithFilterReturnObject(
      String tableName, String column, String value) async {
    try {
      final response = await _client.from(tableName).select().eq(column, value);
      if (response.isNotEmpty) {
        return response.first;
      } else {
        throw Exception('No data found');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  // Function to insert data into a table
  Future<void> insertData(String tableName, Map<String, Object> data) async {
    try {
      await _client.from(tableName).insert(data);
    } catch (e) {
      throw Exception('Error inserting data: $e');
    }
  }

  // Function to insert data into a table and return the inserted record
  Future<Map<String, dynamic>> insertDataGetID(
      String tableName, Map<String, Object> data) async {
    try {
      // Insert the data and fetch the inserted record(s)
      final response = await _client
          .from(tableName)
          .insert(data)
          .select(); // This ensures the inserted data is returned

      if (response.isNotEmpty) {
        return response.first; // Return the first inserted record
      } else {
        throw Exception('No data returned after insert.');
      }
    } catch (e) {
      throw Exception('Error inserting data: $e');
    }
  }

  // Function to update data in a table
  Future<void> updateData(String tableName, Map<String, Object> data,
      Map<String, Object> match) async {
    try {
      await _client.from(tableName).update(data).match(match);
    } catch (e) {
      throw Exception('Error updating data: $e');
    }
  }

  Future<bool> updateRowWithFilter({
    required String tableName,
    required Map<String, dynamic> updatedValues,
    required String column,
    required dynamic value,
  }) async {
    try {
      final response = await _client
          .from(tableName)
          .update(updatedValues) // Pass map of updated values
          .eq(column, value)
          .select();

      return true;
    } catch (e) {
      Log.e("Update error: $e");
      return false;
    }
  }

  // Function to delete data from a table
  Future<void> deleteData(String tableName, Map<String, Object> match) async {
    try {
      await _client.from(tableName).delete().match(match);
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }

  ///  Delete Row
  Future<bool> deleteRow({
    required String tableName,
    required String columnName,
    required dynamic value,
  }) async {
    try {
      final response =
          await _client.from(tableName).delete().eq(columnName, value);

      if (response.isEmpty) {
        Log.w(
            'No record found to delete in $tableName where $columnName = $value');
        return false;
      }

      Log.i('Record deleted successfully from $tableName');
      return true;
    } catch (e) {
      Log.e('Error deleting row from $tableName: $e');
      return false;
    }
  }

  ///  Get Near by Restaurants
  Future<List<Map<String, dynamic>>> getNearbyRestaurants(
      {required double latitude, required double longitude}) async {
    try {
      // final position = await _getCurrentLocation();

      final response = await _client.rpc('get_nearby_restaurants', params: {
        'user_lat': latitude,
        'user_lon': longitude,
        'max_distance': 5000
      });
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      Log.e('Error fetching restaurantsModels: $e');
      return [];
    }
  }

  ///   Insert Order Items
  Future<Map<String, dynamic>> insertOrderItem({
    required int orderId,
    required String menuItemId,
    required int quantity,
    required double pricePerUnit,
    required double itemDiscount,
    required double total,
    String? specialInstructions,
    Map<String, dynamic>? size,
    List<Map<String, dynamic>>? addOns,
    String? image,
    required String name,
    required String restaurantId,
  }) async {
    try {
      final response = await _client.from('order_items').insert({
        'order_id': orderId,
        'menu_item_id': menuItemId,
        'quantity': quantity,
        'price_per_unit': pricePerUnit,
        'item_discount': itemDiscount,
        'total': total,
        'special_instructions': specialInstructions,
        'size': size,
        'add_on': addOns,
        'image': image,
        'name': name,
        'restaurant_id': restaurantId,
      }).select();

      Log.i('Order inserted successfully: $response');
      if (response.isNotEmpty) {
        return response.first; // Return the first inserted record
      } else {
        throw Exception('No data returned after insert.');
      }
    } catch (e) {
      throw Exception('Error inserting order item: $e');
    }
  }

  ///   Get  Orders with items
  Future<List<Map<String, dynamic>>> getOrdersWithItems({
    required String userId,
    required int page, // Page number
    int limit = 5, // Orders per page
  }) async {
    final int start = (page - 1) * limit; // Calculate start index
    final int end = start + limit - 1; // Calculate end index

    try {
      final response = await _client
          .from('orders')
          .select('*, order_items(*)') // Fetch orders with items
          .eq('user_id', userId) // Filter orders by user
          .order('created_at', ascending: false) // Most recent orders first
          .range(start, end); // Pagination range

      if (response.isNotEmpty) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      Log.e('Error fetching orders: $e');
      throw Exception('Error fetching orders: $e');
    }
  }

  // Future<void> uploadFileWithProgress({
  //   required String bucket,
  //   required String filePath,
  //   required File file,
  //   required Function(double) onProgress, // Callback to track progress
  // }) async {
  //   try {
  //     final dio = Dio();
  //     final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
  //
  //     // Get Supabase's storage upload URL
  //     final uploadUrl = _client.storage.from(bucket).getPublicUrl(filePath).publicUrl;      // Upload the file using Dio
  //     final response = await dio.put(
  //       uploadUrl,
  //       data: file.openRead(),
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer ${_client.auth.currentSession?.accessToken}',
  //           'Content-Type': 'application/octet-stream',
  //         },
  //       ),
  //       onSendProgress: (sent, total) {
  //         final progress = (sent / total) * 100;
  //         onProgress(progress); // Callback for progress tracking
  //       },
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('Upload successful: ${response.data}');
  //     } else {
  //       throw Exception('Upload failed with status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error uploading file: $e');
  //   }
  // }

  Future<String?> uploadFile({
    required String bucket,
    required String path,
    required File file,
  }) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

      // Upload directly to Supabase storage
      final storage = _client.storage.from(bucket);

      final response = await storage.upload(
        path + fileName,
        file,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );

      if (response.isEmpty) {
        throw Exception('Failed to upload file. No response from server.');
      } else {
        return response;
      }
    } on StorageException catch (e) {
      throw Exception('Error uploading file: ${e.message}');
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // Stream for real-time updates
  Stream<List<Map<String, dynamic>>> subscribeToTable(String tableName) {
    final stream = _client
        .from(tableName)
        .stream(primaryKey: ['id']) // Replace 'id' with the actual primary key
        .execute();
    return stream;
  }

  /// Reusable method to upload an XFile to Supabase Storage and get the public URL
  Future<String?> uploadImage(
      {required XFile xFile, required String folder}) async {
    try {
      // Convert XFile to File
      File file = File(xFile.path);

      // Generate a unique file name
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      final String filePath = '$folder/$fileName'; // Path inside storage

      // Upload file to Supabase Storage
      await _client.storage.from('images').upload(filePath, file);

      // Get public URL of the uploaded file
      return _client.storage.from('images').getPublicUrl(filePath);
    } on StorageException catch (e) {
      Log.e('Storage Error: ${e.message}');
      return null;
    } catch (e) {
      Log.e('Error uploading file: $e');
      return null;
    }
  }


  Future<void> deleteFileViaUrl(
      {required String bucketName, required String fileUrl}) async {
    try {
      // Parse the URL to get the path
      Uri uri = Uri.parse(fileUrl);
      String path = uri.path;

      // Remove '/storage/v1/object/public/images/' from the path to get filename
      String filePath =
          path.replaceFirst('/storage/v1/object/public/$bucketName/', '');
      Log.d("Deletable split file path: $filePath");
      // Delete the file from the 'images' bucket
      final response =
          await _client.storage.from(bucketName).remove([filePath]);
      if (response.isEmpty) {
        Log.e(
            'Error deleting file: File might not exist or there was an issue with the request.');
      } else {
        Log.i("Successfully deleted file: $filePath");
      }
    } catch (error) {
      Log.e('Error deleting image: $error');
    }
  }
}

