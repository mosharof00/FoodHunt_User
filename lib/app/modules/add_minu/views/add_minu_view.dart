import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/appbar_title.dart';
import '../../../../Utils/cached_image_helper.dart';
import '../../../../Utils/custom_dropdown.dart';
import '../../../../Utils/custom_icon_button.dart';
import '../../../../Utils/input_field_with_label.dart';
import '../../../../Utils/simple_button.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../controllers/add_minu_controller.dart';

class AddMinuView extends GetView<AddMinuController> {
  const AddMinuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          title: appbarTitle(text: 'Add Menu'),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: CustomIconButton(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                //add food image
                Stack(
                  children: [
                    imageWidget(
                      imgurl:
                          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
                      imgHeight: 200.h,
                      imgWidth: 1.sw,
                      fit: BoxFit.cover,
                      radius: 20,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      top: 0,
                      left: 0,
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(80),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            height: 50.h,
                            width: 50.w,
                            child: SvgPicture.asset(
                                fit: BoxFit.contain,
                                Assets.icons.imagePlaceholder),
                          )),
                    )
                  ],
                ),
                //add food name
                SizedBox(
                  height: 15.h,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),
                    // Add food details
                    InputFieldWithLabel(
                      label: "Dish Name",
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 15.h),
                    InputFieldWithLabel(
                      label: "Price",
                      keyboardType: TextInputType.number,
                      suffixText: "USD",
                    ),
                    SizedBox(height: 15.h),
                    InputFieldWithLabel(
                      label: "Description",
                      keyboardType: TextInputType.text,
                      maxLines: 4,
                    ),

                    SizedBox(height: 15.h),

                    // add Size And Price
                    Divider(
                      color: ColorName.gray70,
                      thickness: 1,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Row(
                          children: [
                            AppTextStyle(text: "Size", fontSize: 20),
                            SizedBox(width: 10.w),
                            AppTextStyle(
                                text: "(Required)",
                                fontSize: 16,
                                color: ColorName.appTextGrayColor),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.check_circle,
                              color: ColorName.primaryColor,
                            )
                          ],
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: AppTextStyle(
                              text: "Add More",
                              fontSize: 16,
                              color: ColorName.primaryColor,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      AppTextStyle(
                                        text: "Small",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(width: 10.w),
                                      SvgPicture.asset(
                                        Assets.icons.trash,
                                        height: 20.h,
                                        width: 20.w,
                                        colorFilter: ColorFilter.mode(
                                            ColorName.onPrimary,
                                            BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 100.w,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          color: ColorName.appTextGrayColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.attach_money,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey, // Adjust the color of the border
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorName
                                                .onPrimary, // Adjust the color for the focused state
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorName
                                                .onPrimary, // Adjust the color of the border for enabled state
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // add Size And Price
                    Divider(
                      color: ColorName.gray70,
                      thickness: 1,
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Row(
                          children: [
                            AppTextStyle(text: "Add On", fontSize: 20),
                            SizedBox(width: 10.w),
                            AppTextStyle(
                                text: "(Optional)",
                                fontSize: 16,
                                color: ColorName.appTextGrayColor),
                            SizedBox(width: 10.w),
                            Icon(
                              Icons.circle_outlined,
                              color: ColorName.primaryColor,
                            )
                          ],
                        ),
                        Spacer(),
                        TextButton(
                            onPressed: () {},
                            child: AppTextStyle(
                              text: "Add More",
                              fontSize: 16,
                              color: ColorName.primaryColor,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      imageWidget(
                                        imgurl:
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxBOZ7PaW6aKGqc2oVQvKyy9D0vV0OhVIRgg&s",
                                        imgHeight: 30.h,
                                        imgWidth: 30.w,
                                        fit: BoxFit.cover,
                                        radius: 10,
                                      ),
                                      SizedBox(width: 10.w),
                                      AppTextStyle(
                                        text: "Baby Spinach",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(width: 10.w),
                                      SvgPicture.asset(
                                        Assets.icons.trash,
                                        height: 20.h,
                                        width: 20.w,
                                        colorFilter: ColorFilter.mode(
                                            ColorName.onPrimary,
                                            BlendMode.srcIn),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 100.w,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                          color: ColorName.appTextGrayColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.attach_money,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey, // Adjust the color of the border
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorName
                                                .onPrimary, // Adjust the color for the focused state
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorName
                                                .onPrimary, // Adjust the color of the border for enabled state
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // add Size And Price
                    Divider(
                      color: ColorName.gray70,
                      thickness: 1,
                    ),
                    SizedBox(height: 15.h),

                    AppTextStyle(text: "Availability", fontSize: 20),
                    SizedBox(height: 8.h),
                    AppTextStyle(
                        text: "Start Time",
                        fontSize: 16,
                        color: ColorName.appTextGrayColor),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hour Dropdown
                        Expanded(
                          flex: 1,
                          child: CustomDropdown(
                            items: List.generate(24,
                                (index) => index.toString().padLeft(2, '0')),
                            value: controller.selectedHour.value,
                            onChanged: (value) {
                              controller.selectedHour.value = value!;
                            },
                            hintText: 'Hour',
                          ),
                        ),
                        SizedBox(width: 20),
                        // Minute Dropdown
                        Expanded(
                          flex: 1,
                          child: CustomDropdown(
                            items: List.generate(60,
                                (index) => index.toString().padLeft(2, '0')),
                            value: controller.selectedMinute.value,
                            onChanged: (value) {
                              controller.selectedMinute.value = value!;
                            },
                            hintText: 'Hour',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    AppTextStyle(
                        text: "End Time",
                        fontSize: 16,
                        color: ColorName.appTextGrayColor),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hour Dropdown
                        Expanded(
                          flex: 1,
                          child: CustomDropdown(
                            items: List.generate(24,
                                (index) => index.toString().padLeft(2, '0')),
                            value: controller.selectedHour.value,
                            onChanged: (value) {
                              controller.selectedHour.value = value!;
                            },
                            hintText: 'Hour',
                          ),
                        ),
                        SizedBox(width: 20),
                        // Minute Dropdown
                        Expanded(
                          flex: 1,
                          child: CustomDropdown(
                            items: List.generate(60,
                                (index) => index.toString().padLeft(2, '0')),
                            value: controller.selectedMinute.value,
                            onChanged: (value) {
                              controller.selectedMinute.value = value!;
                            },
                            hintText: 'Hour',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    simpleButton(
                        text: "Add Menu",
                        onPressed: () {},
                        fontWeight: FontWeight.w600,
                        backgroundColor: ColorName.primaryColor,
                        textColor: ColorName.white,
                        borderRadius: 20),

                    SizedBox(
                      height: 100.h,
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
