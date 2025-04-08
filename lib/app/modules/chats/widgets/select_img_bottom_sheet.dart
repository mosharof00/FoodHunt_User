// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:weeklyeat_delivery_app/Utils/app_text_style.dart';
// import 'package:weeklyeat_delivery_app/Utils/global_button.dart';
// import 'package:weeklyeat_delivery_app/Utils/global_divider.dart';
// import 'package:weeklyeat_delivery_app/Utils/global_snackbar.dart';
// import 'package:weeklyeat_delivery_app/Utils/loading_action.dart';
// import 'package:weeklyeat_delivery_app/Utils/sizedbox_extension.dart';
//
// import '../../../../Utils/mehtods/pick_file.dart';
// import '../../register/widgets/selected_file_validation.dart';
// import '../controllers/chats_controller.dart';
//
// Future<void> selectBottomSheet() async {
//   final controller = Get.put(ChatsController());
//   return showModalBottomSheet(
//     context: Get.context!,
//     isScrollControlled: true, // Allows full-screen height if needed
//     builder: (context) {
//       return Container(
//           width: Get.width,
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15.r),
//                 topRight: Radius.circular(15.r),
//               )),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               AppTextStyle(
//                 text: "Upload picked up proof image.",
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//               10.height,
//               globalDivider(height: 0.5),
//               10.height,
//               SelectedFileValidation(
//                 height: 300.h,
//                 width: 200.w,
//                 selectedFile: controller.selectedXFiles,
//                 errorTitle: 'File is not selected',
//                 onTap: ()async{
//                   controller.selectedPickedUpProofImg.value =
//                   await PickFile.pickSingleFile(
//                       imageSource: ImageSource.camera);
//                 },
//                 unSelectedWidget: Container(
//                   height: 300.h,
//                   width: 200.w,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade400,
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),
//                   child: Center(
//                     child: Icon(
//                       Icons.camera_alt_outlined,
//                       size: 50.sp,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//               20.height,
//               Row(
//                 children: [
//                   Expanded(
//                       child: globalButton(
//                           onTap: () {
//                             Get.back();
//                           },
//                           text: "Cancel")),
//                   10.width,
//                   Expanded(child: Obx(() {
//                     if (controller.isPickedUpProofLoading.value) {
//                       return loadingAction();
//                     } else {
//                       return globalButton(
//                           onTap: () {
//                             if (controller.selectedPickedUpProofImg.value !=
//                                 null) {
//                               controller.uploadPickedUpProofImg();
//                             } else {
//                               globalSnackBar(
//                                   title: "Image is not selected!",
//                                   message:
//                                       "Please select an image and try again.");
//                             }
//                           },
//                           text: "Upload");
//                     }
//                   }))
//                 ],
//               )
//             ],
//           ));
//     },
//   );
// }
