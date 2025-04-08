import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Helper/logger.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';
import 'package:food_hunt_user/app/models/coupon_model.dart';
import 'package:food_hunt_user/app/repository/supabase_repository.dart';

class CouponsController extends GetxController {
  //TODO: Implement CouponsControllers;
  final SupabaseRepository _supaRepo = SupabaseRepository();
  late String restaurantId;

  final restaurantDiscountList = <Coupon>[].obs;
  final globalDiscountList = <Coupon>[].obs;
  final isLoading = true.obs;
  final selectedCoupon = Coupon().obs;
  final totalDiscount = 0.0.obs;

  Future<void> fetchDiscount() async {
    try {
      isLoading.value = true;
      final response = await _supaRepo.fetchData('coupons'
          // tableName: 'coupons',
          // column: 'restaurant_id',
          // value: restaurantId,
          );
      List<Coupon> couponList =
          response.map((e) => Coupon.fromJson(e)).toList();

      for (var coupon in couponList) {
        if (coupon.status == true) {
          if (coupon.restaurantId == null) {
            globalDiscountList.add(coupon);
          } else {
            if(coupon.id == restaurantId){
              restaurantDiscountList.add(coupon);
            }
          }
        }
      }
      Log.w('restaurant discount: ${restaurantDiscountList.length}');
      Log.w('global discount: ${globalDiscountList.length}');
      isLoading.value = false;
    } catch (e) {
      Log.e(e);
      isLoading.value = false;
    }
  }

  double calculateDiscount(Coupon coupon, double totalAmount) {
    DateTime now = DateTime.now();

    // Ensure validFrom and validTo are not null
    if (coupon.validFrom == null || coupon.validTo == null) {
      Log.e('Invalid coupon if dates are missing');
      return 0.0; // Invalid coupon if dates are missing
    }

    DateTime validFrom = coupon.validFrom!;
    DateTime validTo = coupon.validTo!;

    // Check if the coupon is within the valid date range
    if (now.isBefore(validFrom) || now.isAfter(validTo)) {
      globalSnackBar(
          durationInSeconds: 2,
          title: 'Coupon is expired!',
          message: 'This coupon is expired. Please try another');
      return 0.0; // Coupon is expired or not yet active
    }

    if (totalAmount < coupon.minOrderValue!) {
      return 0.0; // Order does not meet minimum requirement
    }

    double calculatedDiscount = 0.0;

    if (coupon.discountType == "percentage") {
      calculatedDiscount = (totalAmount * coupon.discountValue!) / 100;
    } else {
      calculatedDiscount = coupon.discountValue!.toDouble();
    }

    // Apply max discount limit
    if (calculatedDiscount > coupon.maxDiscount!) {
      calculatedDiscount = coupon.maxDiscount!.toDouble();
    }
    selectedCoupon.value = coupon;
    return calculatedDiscount;
  }

  String checkDateValidate(Coupon coupon) {
    DateTime now =
        DateTime.now().toUtc(); // Convert to UTC for international time

    if (coupon.validFrom == null || coupon.validTo == null) {
      return "Invalid coupon"; // If date fields are missing
    }

    DateTime validFrom = coupon.validFrom!.toUtc();
    DateTime validTo = coupon.validTo!.toUtc();

    String formattedDateTime =
        "${validTo.year}-${validTo.month.toString().padLeft(2, '0')}-${validTo.day.toString().padLeft(2, '0')} - "
        "${validTo.hour.toString().padLeft(2, '0')}:${validTo.minute.toString().padLeft(2, '0')}";

    if (now.isBefore(validFrom)) {
      return "This coupon is not active yet. It will be valid from - $formattedDateTime";
    } else if (now.isAfter(validTo)) {
      return "This coupon has expired. It was valid until - $formattedDateTime";
    } else {
      return "Expired on - $formattedDateTime"; // Returns both date & time
    }
  }

  String getDiscount(Coupon coupon) {
    if (coupon.discountType == 'percentage') {
      return "${coupon.discountValue} %";
    } else {
      return "${HelperUtils.currencySymbol} ${coupon.discountValue}";
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      restaurantId = Get.arguments;
      Log.w(restaurantId);
    } else {
      Log.e('null');
    }
    fetchDiscount();
    super.onInit();
  }
}
