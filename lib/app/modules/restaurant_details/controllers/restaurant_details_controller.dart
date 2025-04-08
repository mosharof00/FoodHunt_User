import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/app/models/category_model.dart';
import 'package:food_hunt_user/app/modules/cart/controllers/cart_controller.dart';
import 'package:food_hunt_user/app/modules/home/controllers/home_controller.dart';

import '../../../../Helper/logger.dart';
import '../../../models/restaurantsModels/menu_item_model.dart';
import '../../../models/restaurantsModels/restaurants_model.dart';
import '../../../repository/supabase_repository.dart';

class RestaurantDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement RestaurantDetailsController
  final SupabaseRepository _supaRepo = SupabaseRepository();
  final ScrollController scrollController = ScrollController();

  final restaurant = RestaurantModel().obs;

  final isLoading = true.obs;
  late List<MenuItemModel> menuItems = <MenuItemModel>[];

  List<CategoryModel> menuTabBarList = [];
  List<List<MenuItemModel>> menuTabBarViewList = [];

  /// Tab
  late TabController tabController;
  RxInt selectedTabIndex = 0.obs;
  void updateSelectedTab(int index) {
    selectedTabIndex.value = tabController.index;
    tabController.animateTo(tabController.index);
    update();
    // if (selectedTabIndex.value == 1 &&
    //     isWithdrawRequestInitializing.value == 100) {
    //   fetchWithdrawRequestList();
    // }
  }

  // Future<void> fetchMenuItems() async {
  //   try {
  //     isLoading.value = true;
  //     final response = await _supaRepo.fetchDataWithFilter(
  //         tableName: 'menu_items',
  //         column: 'restaurant_id',
  //         value: restaurant.value.id!);
  //
  //     Log.i(response);
  //
  //     // Convert response into a list of MenuItemModel
  //     final List<MenuItemModel> menuItems =
  //         response.map((e) => MenuItemModel.fromJson(e)).toList();
  //
  //     // Extract unique categories from the menu items
  //     final List<CategoryModel> uniqueCategories = [];
  //    final List<List<MenuItemModel>> tabBarViewList = [];
  //
  //     for (var item in menuItems) {
  //       int categoryId = item.category!;
  //       String categoryName = Get.find<HomeController>()
  //           .categoryList.firstWhere((cat) =>cat.id == categoryId).name!;
  //
  //       // If the category doesn't exist, add it
  //       if (!uniqueCategories.any((cat) => cat.id == categoryId)) {
  //         uniqueCategories
  //             .add(CategoryModel(id: categoryId, name: categoryName));
  //       }
  //
  //     }
  //
  //
  //     tabController = TabController(
  //       length: menuTabBarList.length,
  //       vsync: this,
  //     );
  //     isLoading.value = false;
  //   } catch (e) {
  //     Log.e(e);
  //     isLoading.value = false;
  //   }
  // }
  Future<void> fetchMenuItems() async {
    try {
      isLoading.value = true;

      final response = await _supaRepo.fetchDataWithFilter2(
          tableName: 'menu_items',
          column1: 'restaurant_id',
          value1: restaurant.value.id!,
          column2: 'is_available',
          value2: true);
      // Log.i(response);

      // Convert response into a list of MenuItemModel
      menuItems = response.map((e) => MenuItemModel.fromJson(e)).toList();

      // Clear previous data
      menuTabBarList.clear();
      menuTabBarViewList.clear();

      // Add "All" tab
      menuTabBarList.add(CategoryModel(id: 0, name: "All"));
      menuTabBarViewList.add(menuItems); // First tab contains all items

      // Extract unique categories from the menu items
      final Map<int, List<MenuItemModel>> categoryMap = {};

      for (var item in menuItems) {
        int categoryId = item.category!;
        String categoryName = Get.find<HomeController>()
            .categoryList
            .firstWhere((cat) => cat.id == categoryId)
            .name!;

        // If category is not already added, initialize it
        categoryMap.putIfAbsent(categoryId, () => []);
        categoryMap[categoryId]!.add(item);
      }

      // Populate menuTabBarList and menuTabBarViewList
      categoryMap.forEach((id, items) {
        menuTabBarList.add(CategoryModel(
            id: id,
            name: Get.find<HomeController>()
                .categoryList
                .firstWhere((cat) => cat.id == id)
                .name!));
        menuTabBarViewList.add(items);
      });

      // Initialize TabController
      tabController = TabController(
        length: menuTabBarList.length,
        vsync: this,
      );

      await Future.delayed(Duration(seconds: 1));
      isLoading.value = false;
    } catch (e) {
      Log.e(e);
      isLoading.value = false;
    }
  }

// Function to get category name (Dummy implementation, replace with actual logic)
  String getCategoryName(int categoryId) {
    final categoryNames = {
      1: "Burgers",
      2: "Pizzas",
      3: "Drinks",
      // Add more categories as needed
    };
    return categoryNames[categoryId] ?? "Unknown";
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      restaurant.value = Get.arguments;
    }
    Log.i(restaurant.value.id);
    fetchMenuItems();
    Get.put(CartController());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<CartController>();
    super.onClose();
  }
}
