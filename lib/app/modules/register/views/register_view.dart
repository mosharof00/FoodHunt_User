import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/input_field_with_label.dart';
import '../../../../Utils/loading_action.dart';
import '../../../../Utils/password_input_field_with_label.dart';
import '../../../../Utils/simple_button.dart';
import '../../../../Utils/topbar_round_stack.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            topBarRoundStack(
                isShowButton: true,
                onPressed: () {
              Get.back();
            }),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 60.h, left: 20.w, right: 20.w, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                          text: 'Sign Up',
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                      Visibility(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          InputFieldWithLabel(
                            controller: controller.fullNameController,
                            label: "Full Name",
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20.h),
                          InputFieldWithLabel(
                            controller: controller.userNameController,
                            label: "User Name",
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20.h),
                          InputFieldWithLabel(
                            controller: controller.emailController,
                            label: "E-mail",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20.h),
                          InputFieldWithLabel(
                            controller: controller.referCodeController,
                            label: "Referral Code (optional)",
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 20.h),
                          PasswordInputFieldWithLabel(
                            controller: controller.passwordController,
                            hintText: "Password",
                            label: "Password",
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ],
                      )),
                      SizedBox(height: 15.h),
                      Center(
                        child: Obx(() {
                          return controller.isLoading.value
                              ? loadingAction()
                              : simpleButton(
                                  text: "SIGN UP",
                                  onPressed: () {
                                    if (controller.validateInputs()) {
                                      controller.registerUser(role: 'user');
                                    }
                                  },
                                  backgroundColor: ColorName.primaryColor,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  width: 248,
                                  height: 60,
                                  borderRadius: 28.50,
                                );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextStyle(
                              text: "Already have an account?",
                              fontSize: 15,
                              color: ColorName.appTextGrayColor,
                              fontWeight: FontWeight.w400),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: AppTextStyle(
                                text: " Login",
                                fontSize: 15,
                                color: ColorName.primaryColor,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
