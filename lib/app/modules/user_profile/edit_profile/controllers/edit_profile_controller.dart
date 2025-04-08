import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/app/models/user_model.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';

import '../../../../../Helper/logger.dart';
import '../../../../../Utils/global_snackbar.dart';
import '../../../../repository/supabase_repository.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController
  final SupabaseRepository _repository = SupabaseRepository();

  final nameEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  final bioEditingController = TextEditingController();

  final user = UserModel().obs;
  final isUserLoading = false.obs;
  final isUpdating = false.obs;

  /// for profile image
  final selectedProfileImage = Rxn<XFile?>();
  final uploadedProfileImage = "".obs;

  /// for Cover image
  final selectedCoverImage = Rxn<XFile?>();
  final uploadedCoverImage = "".obs;

  ///  Prepare to update user data
  void prepareToUpdateUserData(UserModel user) {
    nameEditingController.text = user.fullName ?? "";
    userNameEditingController.text = user.username ?? "";
    bioEditingController.text = user.bio ?? "";
    uploadedProfileImage.value = user.profileImageUrl ?? "";
    uploadedCoverImage.value = user.coverImage ?? "";
  }

  ///    fetch user
  Future<void> fetchUser(String userId) async {
    try {
      isUserLoading.value = true;
      final response = await _repository.fetchDataWithFilter(
          tableName: "users", column: "id", value: userId);
      Log.i(response.first);
      user.value = UserModel.fromJson(response.first);
      prepareToUpdateUserData(user.value);
      Get.put(HomeController(), permanent: true).user.value = user.value;
      isUserLoading.value = false;
    } catch (e) {
      isUserLoading.value = true;
      Log.e(e);
    }
  }

  ///  update driver
  Future<void> updateUser() async {
    try {
      isUpdating.value = true;

      ///   handle profile image
      if (selectedProfileImage.value != null) {
        final url = await _repository.uploadImage(
          folder: "users_images",
          xFile: selectedProfileImage.value!,
        );
        if (url == null || url.isEmpty) {
          globalSnackBar(
              durationInSeconds: 3,
              textColor: Colors.red.shade700,
              title: "Profile image upload fail!",
              message: "Your profile image uploading fail. Please try again.");

          isUpdating.value = false;
          return;
        } else {
          if (uploadedProfileImage.isNotEmpty) {
            ///  delete previous image from database
            _repository.deleteFileViaUrl(
                bucketName: 'images', fileUrl: uploadedProfileImage.value);
          }
          uploadedProfileImage.value = url;
          Log.w(
              'Updated current profile image: \n${uploadedProfileImage.value}');
        }
      }

      ///   handle Cover image
      if (selectedCoverImage.value != null) {
        final url = await _repository.uploadImage(
          folder: "users_images",
          xFile: selectedCoverImage.value!,
        );
        if (url == null || url.isEmpty) {
          globalSnackBar(
              durationInSeconds: 3,
              textColor: Colors.red.shade700,
              title: "Cover image upload fail!",
              message: "Your Cover image uploading fail. Please try again.");

          isUpdating.value = false;
          return;
        } else {
          if (uploadedCoverImage.isNotEmpty) {
            ///  delete previous image from database
            _repository.deleteFileViaUrl(
                bucketName: 'images', fileUrl: uploadedCoverImage.value);
          }
          uploadedCoverImage.value = url;
          Log.w('Updated current Cover image: \n${uploadedCoverImage.value}');
        }
      }

      final updateAbleData = {
        "full_name": nameEditingController.text,
        "username": userNameEditingController.text,
        "bio": bioEditingController.text,
        "profile_image_url": uploadedProfileImage.value,
        "cover_image": uploadedCoverImage.value,
      };

      final isUpdate = await _repository.updateRowWithFilter(
          tableName: "users",
          updatedValues: updateAbleData,
          column: "id",
          value: HelperUtils.userId);
      if (isUpdate) {
        isUpdating.value = false;
        Get.back();
        globalSnackBar(
            durationInSeconds: 2,
            title: "Success!",
            message: "Personal information updated successfully");
      } else {
        globalSnackBar(
            durationInSeconds: 3,
            textColor: Colors.red,
            title: "Fail update personal info",
            message: "Something went wring. Please try again.");
      }
      isUpdating.value = false;
    } catch (e) {
      isUpdating.value = false;
      Log.e(e);
      globalSnackBar(
          durationInSeconds: 3,
          textColor: Colors.red,
          title: "Fail update personal info",
          message: "Something went wring. Please try again.");
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchUser(HelperUtils.userId);
    super.onInit();
  }
}
