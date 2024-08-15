import 'package:beauty_buyfine_net/controller/bottom_navigation_controller.dart';
import 'package:beauty_buyfine_net/controller/detail_controller.dart';
import 'package:beauty_buyfine_net/controller/list_controller.dart';
import 'package:beauty_buyfine_net/view/list_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
  Get.put(BottomNavigationController(), permanent: true);
  Get.put(ListController(), tag: 'ListHospitalController', permanent: true);
  Get.put(ListController(), tag: 'ListCaseController', permanent: true);
  Get.put(ListController(), tag: 'ListExpertsController', permanent: true);
  Get.put(ListController(), tag: 'ListInfoController', permanent: true);
  Get.lazyPut<DetailController>(() => DetailController(initPageType: 'h'),
      tag: 'DetailHospitalController', fenix: true);
  Get.lazyPut<DetailController>(() => DetailController(initPageType: 'c'),
      tag: 'DetailCaseController', fenix: true);
  Get.lazyPut<DetailController>(() => DetailController(initPageType: 'e'),
      tag: 'DetailExpertsController', fenix: true);
  Get.lazyPut<DetailController>(() => DetailController(initPageType: 'i'),
      tag: 'DetailInfoController', fenix: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF48670F), //29271B, 48670F, be0d2e
          brightness: Brightness.light,
        ),
        // textTheme: GoogleFonts.notoSansNKoTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      //initialBinding: InitBindings(),
      home: ListMain(),
      // routes: {
      //   '/listMain': (p0) => ListMain(),
      // },
    );
  }
}
