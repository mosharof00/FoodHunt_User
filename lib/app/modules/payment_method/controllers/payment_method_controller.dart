import 'package:get/get.dart';

import '../../../../Helper/logger.dart';
import '../../../models/payment_method_model.dart';
import '../../../repository/supabase_repository.dart';

class PaymentMethodController extends GetxController {
  //TODO: Implement PaymentMethodController
  final SupabaseRepository _supaRepo = SupabaseRepository();
  final selectedPaymentMethodIndex = 0.obs;
  PaymentMethodModel? get selectedPaymentMethod =>
      paymentMethodList[selectedPaymentMethodIndex.value];

  final paymentMethodList = <PaymentMethodModel>[].obs;
  final isLoading = false.obs;

  Future<void> fetchPaymentMethod() async {
    try {
      isLoading.value = true;
      final response = await _supaRepo.fetchData('payment_gateways');
      paymentMethodList.value =
          response.map((e) => PaymentMethodModel.fromJson(e)).toList();

      isLoading.value = false;
    } catch (e) {
      Log.e(e);
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchPaymentMethod();
    super.onInit();
  }
}
