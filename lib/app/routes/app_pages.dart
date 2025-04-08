import 'package:get/get.dart';

import '../modules/add_minu/bindings/add_minu_binding.dart';
import '../modules/add_minu/views/add_minu_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/chats/bindings/chats_binding.dart';
import '../modules/chats/views/chats_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/coupons/bindings/coupons_binding.dart';
import '../modules/coupons/views/coupons_view.dart';
import '../modules/explore/bindings/explore_binding.dart';
import '../modules/explore/views/explore_view.dart';
import '../modules/food_details/bindings/food_details_binding.dart';
import '../modules/food_details/views/food_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction_screen/bindings/introduction_screen_binding.dart';
import '../modules/introduction_screen/views/introduction_screen_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/my_orders/bindings/my_orders_binding.dart';
import '../modules/my_orders/order_details/bindings/order_details_binding.dart';
import '../modules/my_orders/order_details/views/order_details_view.dart';
import '../modules/my_orders/views/my_orders_view.dart';
import '../modules/payment_method/bindings/payment_method_binding.dart';
import '../modules/payment_method/views/payment_method_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/restaurant_details/bindings/restaurant_details_binding.dart';
import '../modules/restaurant_details/views/restaurant_details_view.dart';
import '../modules/review_and_trip/bindings/review_and_trip_binding.dart';
import '../modules/review_and_trip/views/review_and_trip_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/track_order/bindings/track_order_binding.dart';
import '../modules/track_order/views/track_order_view.dart';
import '../modules/upload/bindings/upload_binding.dart';
import '../modules/upload/views/upload_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/user_profile/edit_profile/views/edit_profile_view.dart';
import '../modules/user_profile/views/user_profile_view.dart';
import '../modules/wallet/bindings/wallet_binding.dart';
import '../modules/wallet/get_coin/bindings/get_coin_binding.dart';
import '../modules/wallet/get_coin/views/get_coin_view.dart';
import '../modules/wallet/views/wallet_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD,
      page: () => const UploadView(),
      binding: UploadBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANT_DETAILS,
      page: () => const RestaurantDetailsView(),
      binding: RestaurantDetailsBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
      children: [
        GetPage(
          name: _Paths.EDIT_PROFILE,
          page: () => const EditProfileView(),
          binding: EditProfileBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.FOOD_DETAILS,
      page: () => const FoodDetailsView(),
      binding: FoodDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDERS,
      page: () => const MyOrdersView(),
      binding: MyOrdersBinding(),
      children: [
        GetPage(
          name: _Paths.ORDER_DETAILS,
          page: () => const OrderDetailsView(),
          binding: OrderDetailsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PAYMENT_METHOD,
      page: () => const PaymentMethodView(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: _Paths.TRACK_ORDER,
      page: () => const TrackOrderView(),
      binding: TrackOrderBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_AND_TRIP,
      page: () => const ReviewAndTripView(),
      binding: ReviewAndTripBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MINU,
      page: () => const AddMinuView(),
      binding: AddMinuBinding(),
    ),
    GetPage(
      name: _Paths.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
      children: [
        GetPage(
          name: _Paths.GET_COIN,
          page: () => const GetCoinView(),
          binding: GetCoinBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.INTRODUCTION_SCREEN,
      page: () => const IntroductionScreenView(),
      binding: IntroductionScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.COUPONS,
      page: () => const CouponsView(),
      binding: CouponsBinding(),
    ),
    GetPage(
      name: _Paths.CHATS,
      page: () => const ChatsView(),
      binding: ChatsBinding(),
    ),
  ];
}
