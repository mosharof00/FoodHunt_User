import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';

import '../../../../Utils/global_snackbar.dart';
import '../../../repository/supabase_repository.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  // Text Controllers for email and password fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs; // Loading state for the login process

  final SupabaseRepository _supabaseRepository =
      SupabaseRepository(); // Instance of Supabase Repository

  // Login method
  Future<void> login() async {
    isLoading.value = true; // Show loading indicator
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await _supabaseRepository.signIn(email, password);

      // Log.i('Response: $response');
      if (response != null) {
        // Login successful

        if (response.userMetadata!['role'] == 'user') {
          await HelperUtils.setUser(
              id: response.id, role: response.userMetadata!['role']);
          globalSnackBar(
              durationInSeconds: 2,
              title: 'Success!',
              message: 'Login successful!');
          Get.offAllNamed(Routes.MAIN_PAGE);
        } else {
          globalSnackBar(
            durationInSeconds: 2,
            title: 'Login fail',
            message: "Credential doesn't match",
          );
        }
      } else {
        // Login failed
        Get.snackbar(
          'Error',
          'Invalid email or password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      globalSnackBar(
        durationInSeconds: 3,
        title: 'Authentication Error!',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  bool validateInputs() {
    if (emailController.text.isEmpty) {
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Empty Email!',
          message: 'Email is required');

      return false;
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailController.text)) {
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Invalid email!',
          message: 'Invalid email format');
      return false;
    }

    if (passwordController.text.isEmpty) {
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Empty Password!',
          message: 'Password is required');
      return false;
    }

    return true; // All validations passed
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
