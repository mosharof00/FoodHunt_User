import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/appbar_title.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Utils/custom_option_card.dart';
import '../../../../Utils/methods/dialog_helper.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    return Scaffold(
        backgroundColor: ColorName.bgColor,
        appBar: AppBar(
          backgroundColor: ColorName.bgColor,
          surfaceTintColor: ColorName.bgColor,
          centerTitle: true,
          title: appbarTitle(text: 'Settings'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView(
            children: [
              customOptionCard(
                  title: "Edit profile",
                  icon: Assets.icons.user,
                  onTap: () {
                    Get.toNamed(Routes.EDIT_PROFILE);
                  }),
              customOptionCard(
                  title: "Privacy",
                  icon: Assets.icons.shieldUserIcon,
                  onTap: () {}),
              customOptionCard(
                  title: "Refer & Earn",
                  icon: Assets.icons.personsIcon,
                  onTap: () {}),
              customOptionCard(
                  title: "Order History",
                  icon: Assets.icons.orderHistoryIcon,
                  onTap: () {
                    Get.toNamed(Routes.MY_ORDERS);
                  }),
              customOptionCard(
                  title: "Wallet",
                  icon: Assets.icons.wallet,
                  onTap: () {
                    Get.toNamed(Routes.WALLET);
                  }),
              customOptionCard(
                  title: "Get Coins",
                  icon: Assets.icons.coinsIcon,
                  iconColor: ColorName.primaryColor,
                  onTap: () {}),
              customOptionCard(
                  title: "Tax Information",
                  icon: Assets.icons.papersTax,
                  onTap: () {}),
              customOptionCard(
                  title: "Terms & Condition",
                  icon: Assets.icons.fileNote,
                  onTap: () {}),
              customOptionCard(
                  title: "Location",
                  icon: Assets.icons.locationPinIcon,
                  onTap: () {}),
              customOptionCard(
                  title: "Language", icon: Assets.icons.globe, onTap: () {}),
              customOptionCard(
                  title: "Join as a delivery-man",
                  icon: Assets.icons.deliveryIcon,
                  onTap: () {}),
              customOptionCard(
                  title: "Request Verification",
                  icon: Assets.icons.verificationIcon,
                  onTap: () {}),
              customOptionCard(
                  title: "Help & Support",
                  icon: Assets.icons.infoCircle,
                  onTap: () {}),
              customOptionCard(
                  title: "Logout",
                  icon: Assets.icons.logOut,
                  onTap: () {
                    DialogHelper.showDialog(
                        context: context,
                        title: "Log out!",
                        description: "Are you sure you want to log out?",
                        dialogType: DialogType.warning,
                        onOkPress: () {
                          controller.logOut();
                        });
                  },
                  color: Colors.red[100]),
            ],
          ),
        ));
  }
}
