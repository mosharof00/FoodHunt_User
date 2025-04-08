import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/app/modules/cart/controllers/cart_controller.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';
import 'package:food_hunt_user/app/modules/restaurant_details/controllers/restaurant_details_controller.dart';
import 'package:food_hunt_user/app/repository/api_services.dart';
import 'package:food_hunt_user/app/repository/supabase_repository.dart';
import 'package:food_hunt_user/app/routes/app_pages.dart';
import 'package:food_hunt_user/app/services/get_current_location.dart';
import 'package:food_hunt_user/gen/colors.gen.dart';

import '../../../../Helper/logger.dart';
import '../../../../Utils/app_text_style.dart';
import '../../../../Utils/global_snackbar.dart';
import '../../../../Utils/methods/method_helper.dart';
import '../../../models/restaurantsModels/restaurants_model.dart';
import '../../payment_method/controllers/payment_method_controller.dart';
import '../widgets/webview.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  final SupabaseRepository _repository = SupabaseRepository();
  ApiServices apiServices = ApiServices();

  final addressEditingController = TextEditingController();
  final specialInstructionsEditingController = TextEditingController();
  final cartController = Get.find<CartController>();
  final paymentMethodController = Get.put(PaymentMethodController());
  late RestaurantModel restaurant;
  final total = 0.0.obs;
  final deliveryFee = 0.0.obs;
  final discount = 0.0.obs;
  final couponCode = "".obs;

  final isOrderLoading = false.obs;
  final isLoading = false.obs;
  final orderedId = 0.obs;

  ///  for address
  final selectedAddress = AddressModel().obs;
  final isLocationLoading = false.obs;
  final isAddressValid = false.obs;
  final specialInstructions = "".obs;

  void updateAddressValidation(String value) {
    addressEditingController.text = value;
    isAddressValid.value = value.length >= 15;
  }

  ///  for tips
  final tip = 0.0.obs;
  final selectedTipIndex = 0.obs;
  final tipList = [0, 2, 3, 5, 10];

  void getTotal() {
    total.value = (cartController.total.value + deliveryFee.value + tip.value) -
        discount.value;
  }
// 'special_instructions';

  ///   Get location
  Future<void> getLocation(String address) async {
    try {
      isLocationLoading.value = true;
      Get.dialog(
        barrierColor: Colors.black54,
        Center(
            child: LoadingAnimationWidget.threeArchedCircle(
                color: ColorName.primaryColor, size: 40.sp)),
        barrierDismissible: false,
      );

      final response = await LocationService.getLatLngFromAddress(address);

      if (response != null) {
        selectedAddress.value = response;
        specialInstructions.value = specialInstructionsEditingController.text;
        specialInstructionsEditingController.clear();
        addressEditingController.clear();
        final distance = LocationService.getDistanceInMeters(
            startLatitude: restaurant.latitude!,
            startLongitude: restaurant.longitude!,
            endLatitude: selectedAddress.value.latitude!,
            endLongitude: selectedAddress.value.longitude!);
        deliveryFee.value = MethodHelper.getDeliveryCharge(distance);

        Get.back();
        globalSnackBar(
            durationInSeconds: 2,
            title: 'Location added successfully!',
            message: 'Your new location has been added');
      } else {
        Get.back();
        globalSnackBar(
            durationInSeconds: 3,
            textColor: Colors.red,
            title: 'Location not found!',
            message: 'No location found for the provided address.');
      }
      isLocationLoading.value = false;
    } catch (e) {
      Get.back();
      isLocationLoading.value = false;
      Log.e(e);
    }
  }

  Future<void> insertOrder() async {
    isOrderLoading.value = true;
    final supabase = Supabase.instance.client;
    Log.i(HelperUtils.userId);

    try {
      final order = await supabase
          .from('orders')
          .insert({
            'user_id': HelperUtils.userId,
            'restaurant_id': restaurant.id,
            'delivery_driver_id': null,
            'order_status': 'Pending',
            'subtotal': cartController.subTotal.value,
            'discount': discount.value,
            'promo_code': couponCode.value,
            'total': total.value,
            'service_charge': cartController.serviceCharge,
            'payment_gateway_id':
                paymentMethodController.selectedPaymentMethod!.id,
            'payment_status': 'Due',
            'payment_method':
                paymentMethodController.selectedPaymentMethod!.name,
            'payment_method_logo':
                paymentMethodController.selectedPaymentMethod!.logoUrl,
            'delivery_fee': deliveryFee.value,
            'tip': tip.value,
            'address': selectedAddress.value.address,
            'latitude': selectedAddress.value.latitude,
            'longitude': selectedAddress.value.longitude,
            'special_instructions': specialInstructions.value,
            'item_qty': cartController.cartList.length,
            'restaurant_name': restaurant.restaurantName,
            'restaurant_profile_image': restaurant.profile,
            'customer_name': Get.find<HomeController>().user.value.fullName
          })
          .select('id')
          .single();

      final orderId = order['id'];
      if (orderId != null) {
        Log.w(
            'Order inserted successfully. now going to insert order items. \n orderId : ${order['id']}');
        List<String> uploadedItems = [];

        for (final item in cartController.cartList) {
          try {
            final response = await _repository.insertOrderItem(
              orderId: orderId,
              menuItemId: item.id,
              quantity: item.qty,
              pricePerUnit: item.basePrice,
              itemDiscount: 0.0,
              total: item.totalPrice,
              specialInstructions: specialInstructions.value,
              image: item.imageUrl,
              name: item.name,
              restaurantId: restaurant.id!,
              size: item.sizes,
              addOns:
                  item.additionalItems?.map((addOn) => addOn.toJson()).toList(),
            );
            uploadedItems.add(item.id);
            Log.i(
                "Order Item is inserted successfully. \n id: ${response['id']}");
          } catch (e) {
            ///   fail order item insert
            globalSnackBar(
                title: 'Fail item order for ${item.name}!',
                message:
                    'Your ${item.name} item order has failed. Please try again with the item.',
                durationInSeconds: 5,
                textColor: Colors.red);
            Log.e(e);
          }
        }
        if (uploadedItems.isEmpty) {
          ///   fail order all items insert
          final orderDeleted = await _repository.deleteRow(
              tableName: 'orders', columnName: 'id', value: orderId);
          if (orderDeleted) {
            Log.w('Failed Order row is deleted from the database');
          } else {
            Log.e('Empty item order is not delete from the database');
          }
          globalSnackBar(
              title: 'Fail place order!',
              message: 'Your order confirmation fail. Please try again later.',
              durationInSeconds: 3,
              textColor: Colors.red);
        } else {
          if (paymentMethodController.selectedPaymentMethod!.name ==
              'my balance') {
            Get.offAllNamed(Routes.MY_ORDERS);
            globalSnackBar(
              title: 'Order confirmed successfully!',
              message:
                  'Your order is successfully placed. Please check out orders history to track and all info.',
              durationInSeconds: 2,
            );
          } else {
            try {
              orderedId.value = orderId;
              final response = await apiServices.payment(
                  userId: HelperUtils.userId,
                  totalAmount: total.value,
                  restaurantName: restaurant.restaurantName!,
                  restaurantImage:
                      restaurant.profile ?? HelperUtils.defaultProfileImage,
                  paymentMethod:
                      paymentMethodController.selectedPaymentMethod!.name!);

              if (response.url != null) {
                isOrderLoading.value = false;
                Log.i("Payment URL: ${response.url}");

                Get.to(() => PaymentWebViewScreen(url: response.url!));
              } else {
                Get.offAllNamed(Routes.MY_ORDERS);
                globalSnackBar(
                    title: 'Fail payment confirmation!',
                    message:
                        'Your order payment confirmation fail. Payment status will be Due of your this order. Please Check your order.',
                    durationInSeconds: 5,
                    textColor: Colors.red);
              }
            } catch (e) {
              Get.offAllNamed(Routes.MY_ORDERS);
              globalSnackBar(
                  title: 'Fail payment confirmation!',
                  message:
                      'Your order payment confirmation fail. Payment status will be Due of your this order. Please Check your order.',
                  durationInSeconds: 5,
                  textColor: Colors.red);
            }
          }
        }
      } else {
        isOrderLoading.value = false;
        globalSnackBar(
            title: 'Fail place order!',
            message: 'Your order confirmation fail. Please try again.',
            durationInSeconds: 3,
            textColor: Colors.red);
      }
    } catch (error) {
      isOrderLoading.value = false;
      globalSnackBar(
          title: 'Fail place order!',
          message: 'Your order confirmation fail. Please try again later.',
          durationInSeconds: 3,
          textColor: Colors.red);
      Log.e('Error inserting order: $error');
    } finally {
      isOrderLoading.value = false;
    }
  }

  // Show loading dialog
  void showLoadingDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: ColorName.gray70,
        elevation: 3,
        title: LoadingAnimationWidget.threeArchedCircle(
          size: 40,
          color: ColorName.primaryColor,
        ),
        content: AppTextStyle(
          text: 'Processing Payments...',
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      barrierDismissible: true,
    );
  }

  //Close Dialog
  void closeLoadingDialogIfOpen() {
    if (Get.isDialogOpen!) {
      Get.back(); // Close the dialog if it's still open
    }
  }

  void updateOrderPaymentStatusToPaid() async {
    try {
      bool response = await _repository.updateRowWithFilter(
          tableName: 'orders',
          updatedValues: {'payment_status': 'Paid'},
          column: 'id',
          value: orderedId);
      if (response == true) {
        Log.i("Update order payment_status to Paid");
      } else {
        Log.e("Fail Update ordered payment_status to Paid");
      }
    } catch (e) {
      Log.e("Fail Update ordered payment_status to Paid. \n $e");
    }
  }

  Future<void> deleteOrder({required int orderId}) async {
    try {
      final response = _repository.deleteData('orders', {'id': orderId});
      Log.i("order deleted from database $response");
    } catch (e) {
      Log.e('Fail order delete');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    final restaurantDetailsController = Get.find<RestaurantDetailsController>();
    restaurant = restaurantDetailsController.restaurant.value;
    deliveryFee.value = MethodHelper.getDeliveryCharge(
        restaurantDetailsController.restaurant.value.distance!);
    selectedAddress.value = AddressModel(
      address: HelperUtils.address,
      latitude: HelperUtils.latitude,
      longitude: HelperUtils.longitude,
    );
    getTotal();
    super.onInit();
  }
}
