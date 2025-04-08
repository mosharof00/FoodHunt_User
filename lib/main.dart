import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:food_hunt_user/Helper/helper_utils.dart';
import 'package:food_hunt_user/app/services/get_current_location.dart';

import 'Helper/logger.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/services/local_store_config.dart';
import 'appConfig.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///    Initialize Firebase
  //
  //
  // await Firebase.initializeApp(
  //   name:AppConfig.appFirebase,
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await Supabase.initialize(
    url: AppConfig.SUPABASE_URL,
    anonKey: AppConfig.SUPABASE_ANON_KEY,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => GetMaterialApp(
        textDirection: TextDirection.ltr,
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,

        ///  Routing Initialization
        initialRoute: AppPages.INITIAL,
        initialBinding: HomeBinding(),
        getPages: AppPages.routes,

        // ///  Language Initialization
        // translations: Languages(),
        // locale: HelperUtils.locateLanguage(),
        // fallbackLocale: HelperUtils.locateLanguage(),
      ),
      designSize: const Size(360, 800),
    );
  }
}

