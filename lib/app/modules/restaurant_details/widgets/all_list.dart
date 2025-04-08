import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/food_item_list_layout.dart';

import '../../../models/restaurantsModels/menu_item_model.dart';
import '../../../routes/app_pages.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.foodItemList});
  final List<MenuItemModel> foodItemList;

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      padding: EdgeInsets.zero,
        itemCount: foodItemList.length,
        itemBuilder: (context, index) {
          final foodItem = foodItemList[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 300),
            child: ScaleAnimation(
              child: FoodItemListLayout(
                foodItem: foodItem,
                onTap: () {
                  Get.toNamed(Routes.FOOD_DETAILS, arguments: {
                    'food': foodItem,
                  });
                },
              ),
            ),
          );
        });
  }
}
