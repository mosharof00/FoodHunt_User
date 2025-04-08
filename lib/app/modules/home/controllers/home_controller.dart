import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/Helper/logger.dart';
import 'package:food_hunt_user/app/models/category_model.dart';
import 'package:food_hunt_user/app/repository/supabase_repository.dart';

import '../../../../Utils/global_snackbar.dart';
import '../../../models/restaurantsModels/restaurants_model.dart';
import '../../../models/static_food_model.dart';
import '../../../models/user_model.dart';
import '../../../services/geocoding_services.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final SupabaseRepository _repository = SupabaseRepository();
  final GooglePlacesService _placesService = GooglePlacesService();

  ///  for user info
  final user = UserModel().obs;
  final isUserLoading = false.obs;

  final nearByRestaurantList = <RestaurantModel>[].obs;
  final isLoading = true.obs;

  ///   get new address
  final addressEditingController = TextEditingController();
  final isAddressValid = false.obs;
  final isGettingLocation = false.obs;
  final location = Rxn<LatLng>();
  final newAddress = "".obs;

  ///  for category
  final categoryList = <CategoryModel>[].obs;

///   fetch near by restaurants
  Future<void> fetchRestaurants(LatLng latLng) async {
    try {
      isLoading.value = true;
      final response = await _repository.getNearbyRestaurants(
          latitude: latLng.latitude, longitude: latLng.longitude);
      nearByRestaurantList.value =
          response.map((data) => RestaurantModel.fromJson(data)).toList();
      // Log.i(response);
      isLoading.value = false;
    } catch (e) {
      Log.e(e);
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryList() async {
    try {
      final response = await _repository.fetchData('categories');
      categoryList.value = categoryModelFromJson(jsonEncode(response));
    } catch (e) {
      Log.e(e);
    }
  }

  ///  Get location
  Future<LatLng?> getLatLng(String address) async {
    try {
      isGettingLocation.value = true;
      final coordinates = await _placesService.getCoordinatesFromPlace(address);
      if (coordinates != null) {
        final latitude = coordinates['latitude'];
        final longitude = coordinates['longitude'];
        return LatLng(latitude!, longitude!);
      } else {
        globalSnackBar(
            durationInSeconds: 3,
            title: 'Location verifying fail!',
            message:
                "We couldn't find this location. Please enter a valid address related to google map and try again.");
        return null;
      }
    } catch (e) {
      globalSnackBar(
          durationInSeconds: 3,
          title: 'Location verifying fail!',
          message:
              "We couldn't find this location. Please enter a valid address related to google map and try again.");
      Log.e(e);
      return null;
    } finally {
      isGettingLocation.value = false;
    }
  }

  Future<void> fetchUser(String userId) async {
    try {
      isUserLoading.value = true;
      final response = await _repository.fetchDataWithFilter(tableName: "users", column: "id", value: userId);
      Log.i(response.first);
      user.value = UserModel.fromJson(response.first);
      isUserLoading.value = false;
    } catch (e) {
      isUserLoading.value = true;
      Log.e(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    location.value = LatLng(HelperUtils.latitude, HelperUtils.longitude);
    newAddress.value = HelperUtils.address;
    fetchRestaurants(LatLng(HelperUtils.latitude, HelperUtils.longitude));
    fetchCategoryList();
    fetchUser(HelperUtils.userId);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    addressEditingController.dispose();
    super.onClose();
  }

  final List<FoodStaticModel> sampleFoodList = [
    FoodStaticModel(
      id: '1',
      name: 'Chicken Hawaiian Pizza',
      restaurantName: 'Super Chef',
      sellerName: 'Smith Clark',
      imageUrl:
          'https://i.pinimg.com/736x/72/d9/af/72d9af964d384fc2a16fd087c1062a7c.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/736x/27/21/47/27214762c359c67b09687875eadbbedb.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/d2/35/47/d2354797cfb995122e8bf0248cb1fd76.jpg',
      rating: 4.7,
      numberOfRatings: 25,
      price: 3.50,
      deliveryTime: DateTime(2025, 1, 22, 18, 15),
      duration: '10-15 mins',
      distance: 1.2,
      quantity: 1,
      availableQuantity: 3,
      isAvailable: true,
      shortDescription:
          'Classic Hawaiian pizza topped with grilled chicken, pineapple, and mozzarella',
      discount: 15.0,
    ),
    FoodStaticModel(
      id: '2',
      name: 'Margherita Pizza',
      restaurantName: 'Pizza Express',
      sellerName: 'Emma Wilson',
      imageUrl:
          'https://i.pinimg.com/736x/78/c4/33/78c433eb22a7fb53e31df6150ca867b2.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/736x/0f/27/7f/0f277f5f07a6399788894bc1062b5308.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/12/ac/60/12ac606896dfc98f4806b7acababed67.jpg',
      rating: 4.9,
      numberOfRatings: 42,
      price: 4.20,
      deliveryTime: DateTime(2025, 1, 22, 18, 30),
      duration: '15-20 mins',
      distance: 0.8,
      quantity: 1,
      availableQuantity: 5,
      isAvailable: true,
      shortDescription:
          'Traditional Italian pizza with fresh basil, tomatoes, and buffalo mozzarella',
      discount: 0.0,
    ),
    FoodStaticModel(
      id: '3',
      name: 'Pepperoni Special',
      restaurantName: 'Dominos',
      sellerName: 'John Baker',
      imageUrl:
          'https://i.pinimg.com/474x/1a/a5/1f/1aa51fc32dceedd750d8a452eabd6223.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/0e/bd/15/0ebd156382f981b213beba52910573b6.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/ff/0c/ba/ff0cba2cd3cd94cf268cc22431b2dec2.jpg',
      rating: 4.5,
      numberOfRatings: 31,
      price: 5.99,
      deliveryTime: DateTime(2025, 1, 22, 19, 00),
      duration: '20-25 mins',
      distance: 2.1,
      quantity: 1,
      availableQuantity: 8,
      isAvailable: true,
      shortDescription:
          'Double pepperoni pizza with extra cheese and Italian herbs',
      discount: 20.0,
    ),
    FoodStaticModel(
      id: '4',
      name: 'Vegetarian Supreme',
      restaurantName: 'Green Bites',
      sellerName: 'Sarah Green',
      imageUrl:
          'https://i.pinimg.com/236x/73/0e/a0/730ea0804f20f0a7184877b25ddf2e1e.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/15/79/63/157963965627e71f6947b3d3d27fec7b.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/62/dc/ad/62dcad630ae133cc66c8adfe4dc95e4b.jpg',
      rating: 4.8,
      numberOfRatings: 19,
      price: 4.75,
      deliveryTime: DateTime(2025, 1, 22, 18, 45),
      duration: '15-20 mins',
      distance: 1.5,
      quantity: 1,
      availableQuantity: 4,
      isAvailable: true,
      shortDescription:
          'Loaded with fresh vegetables, mushrooms, olives, and bell peppers',
      discount: 10.0,
    ),
    FoodStaticModel(
      id: '5',
      name: 'BBQ Chicken Pizza',
      restaurantName: 'BBQ House',
      sellerName: 'Mike Brown',
      imageUrl:
          'https://i.pinimg.com/236x/93/55/6c/93556c01533609a7cac54d0c2c15216a.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/5b/4d/7d/5b4d7d2173dd37f3468ed33adcb743ed.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/474x/24/f0/ac/24f0acd880c38619fa995f2afc9ae0cb.jpg',
      rating: 4.6,
      numberOfRatings: 28,
      price: 6.50,
      deliveryTime: DateTime(2025, 1, 22, 19, 15),
      duration: '25-30 mins',
      distance: 2.8,
      quantity: 1,
      availableQuantity: 6,
      isAvailable: true,
      shortDescription: 'Smokey BBQ chicken with red onions and cilantro',
      discount: 5.0,
    ),
    FoodStaticModel(
      id: '6',
      name: 'Seafood Delight',
      restaurantName: 'Ocean Pizza',
      sellerName: 'Lisa Marine',
      imageUrl:
          'https://i.pinimg.com/236x/9d/20/f0/9d20f0cbfd055feaf0d8520128f4752e.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/74/22/a3/7422a3e2a6bf7ef17c85a43eea99a015.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/736x/fb/0d/57/fb0d57d59282c4a0a6b7b93146d7c8b5.jpg',
      rating: 4.4,
      numberOfRatings: 15,
      price: 7.99,
      deliveryTime: DateTime(2025, 1, 22, 19, 30),
      duration: '20-25 mins',
      distance: 3.0,
      quantity: 1,
      availableQuantity: 2,
      isAvailable: true,
      shortDescription:
          'Premium pizza topped with shrimp, calamari, and mussels',
      discount: 0.0,
    ),
    FoodStaticModel(
      id: '7',
      name: 'Four Cheese',
      restaurantName: 'Cheese lovers',
      sellerName: 'David White',
      imageUrl:
          'https://i.pinimg.com/236x/84/4d/77/844d777c0c27906d4d9c6ea064aba69a.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/6c/8f/ac/6c8fac06bf158a157a3123d48635c582.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/bf/92/6a/bf926a40d6c4f023b68f75ee3d97d929.jpg',
      rating: 4.9,
      numberOfRatings: 35,
      price: 5.50,
      deliveryTime: DateTime(2025, 1, 22, 18, 20),
      duration: '15-20 mins',
      distance: 1.7,
      quantity: 1,
      availableQuantity: 7,
      isAvailable: true,
      shortDescription:
          'Blend of mozzarella, gorgonzola, parmesan, and ricotta cheese',
      discount: 12.0,
    ),
    FoodStaticModel(
      id: '8',
      name: 'Spicy Mexican',
      restaurantName: 'Hot & Spicy',
      sellerName: 'Carlos Rodriguez',
      imageUrl:
          'https://i.pinimg.com/236x/3f/d2/8f/3fd28fc92e52c1a73dc8cb7fd353c326.jpg',
      restaurantImageUrl: 'assets/images/hot_spicy.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/0c/9d/e5/0c9de543d173163dc241c7f38fbe060f.jpg',
      rating: 4.3,
      numberOfRatings: 22,
      price: 6.25,
      deliveryTime: DateTime(2025, 1, 22, 19, 45),
      duration: '20-25 mins',
      distance: 2.4,
      quantity: 1,
      availableQuantity: 4,
      isAvailable: true,
      shortDescription:
          'Spicy pizza with jalapeños, ground beef, and Mexican spices',
      discount: 8.0,
    ),
    FoodStaticModel(
      id: '9',
      name: 'Mushroom Truffle',
      restaurantName: 'Luxury Bites',
      sellerName: 'Oliver James',
      imageUrl:
          'https://i.pinimg.com/236x/3d/3c/76/3d3c76efc8ea1ddd0419d1591c13925a.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/35/10/23/351023b90034c5573f72de8b81cc43ff.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/af/ae/7d/afae7db1f7c3e726c9d6893fb81754e1.jpg',
      rating: 5.0,
      numberOfRatings: 12,
      price: 9.99,
      deliveryTime: DateTime(2025, 1, 22, 20, 00),
      duration: '25-30 mins',
      distance: 3.5,
      quantity: 1,
      availableQuantity: 3,
      isAvailable: true,
      shortDescription:
          'Premium pizza with truffle oil and assorted wild mushrooms',
      discount: 0.0,
    ),
    FoodStaticModel(
      id: '10',
      name: 'Garden Fresh',
      restaurantName: 'Fresh & Healthy',
      sellerName: 'Alice Green',
      imageUrl:
          'https://i.pinimg.com/474x/fb/38/ea/fb38ea428f90069894f83bc9d3530781.jpg',
      restaurantImageUrl:
          'https://i.pinimg.com/236x/c9/32/9e/c9329ea6c6c2cf5610b34dbef34ac30a.jpg',
      sellerImageUrl:
          'https://i.pinimg.com/236x/38/d7/fd/38d7fd5a03bd9595dd1409d2c0c9f2bb.jpg',
      rating: 4.7,
      numberOfRatings: 27,
      price: 5.25,
      deliveryTime: DateTime(2025, 1, 22, 18, 50),
      duration: '15-20 mins',
      distance: 1.9,
      quantity: 1,
      availableQuantity: 5,
      isAvailable: true,
      shortDescription: 'Fresh garden vegetables with a light pesto sauce base',
      discount: 15.0,
    ),
  ];
}
