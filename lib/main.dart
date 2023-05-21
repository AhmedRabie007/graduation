import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graduation/core/network_viewmodel.dart';
import 'package:graduation/core/viewmodel/home_viewmodel.dart';
import 'package:graduation/view/control_view.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  Get.put(HomeViewModel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(

      builder: (context, orientation) => ScreenUtilInit(
        designSize: orientation == Orientation.portrait
            ? const Size(375, 812)
            : const Size(812, 375),
        builder: (context, state) => GetMaterialApp(
          initialBinding: Binding(),
          theme: ThemeData(
            fontFamily: 'SourceSansPro',
          ),
          home: const ControlView(),
          debugShowCheckedModeBanner: false,
          title: 'V7',
        ),
      ),
    );
  }
}
