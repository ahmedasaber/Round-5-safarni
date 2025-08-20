import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/services/bloc_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/core/utils/on_generate_routes.dart';
import 'package:safarni/features/hotel/presentation/views/screens/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/hotel_about_view_body.dart';
import 'package:safarni/features/splash/presentaion/pages/splash_page.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      try {
        await ScreenUtil.ensureScreenSize();
      } catch (e) {
        debugPrint('ScreenUtil initialization failed: $e');
      }
      await setupGetIt();
      Bloc.observer = BlocObserverService();
      runApp(const SafarniApp());
    },
    (error, stack) {
      debugPrint('App Error: $error');
      debugPrint('Stack: $stack');
    },
  );
}

class SafarniApp extends StatelessWidget {
  const SafarniApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HotelAboutPage.routeName,
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
// WelcomeScreen.routeName,