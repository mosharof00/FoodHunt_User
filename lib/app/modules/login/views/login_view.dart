import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/sizedbox_extension.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/input_field_with_label.dart';
import '../../../../Utils/loading_action.dart';
import '../../../../Utils/password_input_field_with_label.dart';
import '../../../../Utils/simple_button.dart';
import '../../../../Utils/topbar_round_stack.dart';
import '../../../../gen/colors.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            topBarRoundStack(onPressed: () {
              Get.back();
            }),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 150.h, left: 20.w, right: 20.w, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextStyle(
                          text: 'Login',
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputFieldWithLabel(
                            label: "E-mail",
                            hintText: "Your email or username",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
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
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextStyle(
                              text: "Forgot Password?",
                              fontSize: 15,
                              color: ColorName.appTextRedColor,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      Center(
                        child: Obx(() {
                          return controller.isLoading.value
                              ? loadingAction()
                              : simpleButton(
                                  text: "Login",
                                  onPressed: () {
                                   if(controller.validateInputs()){
                                     controller.login();
                                   }
                                  },
                                  backgroundColor: ColorName.primaryColor,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  width: 248,
                                  height: 50,
                                  borderRadius: 28.50,
                                );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTextStyle(
                              text: "Don't have an account?",
                              fontSize: 15,
                              color: ColorName.appTextGrayColor,
                              fontWeight: FontWeight.w400),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: AppTextStyle(
                                text: " Sign Up",
                                fontSize: 15,
                                color: ColorName.primaryColor,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      30.height,

                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
