import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/supabase_error_handler.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Helper/logger.dart';
import '../../../repository/supabase_repository.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final SupabaseRepository _repository = SupabaseRepository();

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final referCodeController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  // Register Restaurant
  Future<void> registerUser({required String role}) async {
    isLoading.value = true;
    final user = await _repository.signUp(
        emailController.text, passwordController.text, role);
    if (user == null) {
      return;
    }

    final userRole = user.userMetadata!['role'];

    try {
      // Prepare Restaurant Data
      final userData = <String, Object>{
        'id': user.id,
        'full_name': fullNameController.text,
        'email': emailController.text,
        'username': userNameController.text,
        'password': passwordController.text,
        'referral_code': referCodeController.text,
        'user_type': user.userMetadata!['role'],
      };

      Log.w('Restaurant Data: $userData');
      final insertedRecord =
          await _repository.insertDataGetID('users', userData);

      final id = insertedRecord['id'];
      HelperUtils.setUser(id: id, role: userRole);
      Get.offAllNamed(Routes.MAIN_PAGE);
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Success!',
          message: 'Restaurant registered successfully');
    } catch (e) {
      Log.e('Error: $e');
      globalSnackBar(
          durationInSeconds: 5,
          title: 'Error!',
          message: supabaseErrorHandler(e));
    } finally {
      isLoading.value = false;
    }
  }

  bool validateInputs() {
    if (fullNameController.text.isEmpty) {
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Empty name!',
          message: 'Full name is required');
      return false;
    }

    if (userNameController.text.isEmpty) {
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Empty User Name!',
          message: 'Username is required');

      return false;
    }

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
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    referCodeController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
