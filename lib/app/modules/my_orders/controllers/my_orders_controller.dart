import 'package:get/get.dart';
import 'package:food_hunt_user/Utils/global_snackbar.dart';

import '../../../../Helper/helper_utils.dart';
import '../../../../Helper/logger.dart';
import '../../../models/order_model.dart';
import '../../../repository/supabase_repository.dart';

class MyOrdersController extends GetxController {
  //TODO: Implement MyOrdersController
  final SupabaseRepository _repository = SupabaseRepository();

  List<String> statusList = ['Active', 'Delivered'];

  final isInitialize = 100.obs;
  final isLoading = false.obs;
  final currentPage = 0.obs;
  final isEndPage = false.obs;
  final orderList = <Order>[].obs;

  Future<void> fetchOrders() async {
    try {
      if (isInitialize.value == 100) {
        isInitialize.value = 1;
        currentPage.value = 1;
        isEndPage.value = false;
      }
      isLoading.value = true;
      final response = await _repository.getOrdersWithItems(
        userId: HelperUtils.userId,
        page: currentPage.value,
      );
      final orders = response
          .map((order) => Order.fromJson(order))
          .toList(); // get response into a model
      if (response.isNotEmpty) {
        if (currentPage.value == 1) {
          orderList.value = orders;
        } else {
          orderList.addAll(orders);
        }
        currentPage.value++;
      } else {
        isEndPage.value = true;
        Log.w('No more orders to load.');
      }
      isLoading.value = false;
      if (isInitialize.value == 1) {
        isInitialize.value = 0;
      }
    } catch (e) {
      isLoading.value = false;
      if (isInitialize.value == 1) {
        isInitialize.value = 2;
      }
      Log.e(e);
      globalSnackBar(title: 'Error!', message: 'Something went wrong');
    }
  }

  @override
  onInit() {
    // TODO: implement onInit
    fetchOrders();
    super.onInit();
  }
}
