import 'package:get/get.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';

import '../../../../Helper/logger.dart';
import '../../../routes/app_pages.dart';
import '../../../services/get_current_location.dart';
import '../../../services/local_store_config.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  Future<void> _navigateToMainPage() async {
    await _setupApp();
    await Future.delayed(Duration(seconds: 1));

    if (await HiveService.getOnBoardShowed()) {
      if (await HiveService.checkLoginStatus()) {
        /// 🔥 Initialize controllers **only after confirming login status**
        await HelperUtils.initializeMainControllers();
        Get.offAllNamed(Routes.MAIN_PAGE);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    } else {
      Get.offAllNamed(Routes.INTRODUCTION_SCREEN);
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    _navigateToMainPage();
    super.onInit();
  }
}

///  Initialization  Local Storage Hive, Firebase Notification
Future<void> _setupApp() async {
  await HiveService.initHive();
  // final permission = await determinePosition();
  // HelperUtils.latitude = permission.latitude;
  // HelperUtils.longitude = permission.longitude;
  String address = await LocationService.getAddressFromLatLng();
  HelperUtils.address = address;
  Log.i(address);
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await NotificationManager().initialize();
  // String? firebaseToken;

  // if (Platform.isIOS) {
  //   // await FirebaseMessaging.instance.getAPNSToken();
  //   // firebaseToken = await FirebaseMessaging.instance.getToken();
  // } else {
  //   firebaseToken = await FirebaseMessaging.instance.getToken();
  // }
  //
  // if (firebaseToken != null) {
  //   HiveService.deleteFirebaseToken();
  //   HiveService.setFirebaseToken(firebaseToken);
  //   HelperUtils.firebaseToken = (await HiveService.getFirebaseToken())!;
  // }
}
