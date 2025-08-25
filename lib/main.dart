import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/services/bloc_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/core/utils/on_generate_routes.dart';
import 'package:safarni/features/splash/presentaion/pages/splash_page.dart';
import 'package:safarni/features/profile/presentation/views/screens/profile_view.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart' hide AuthRemoteDataSourceImpl;
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'core/id/service_locator.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/update_password_usecase.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';
import 'features/auth/presentaion/cubit/auth_cubit.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      try {
        await ScreenUtil.ensureScreenSize();
      } catch (e) {
        debugPrint('ScreenUtil initialization failed: $e');
      }

      Bloc.observer = BlocObserverService();
      await Hive.initFlutter();
      await Hive.openBox('favorites');
      final searchHistoryBox = await Hive.openBox<String>('searchHistory');
      setupGetIt(searchHistoryBox);
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

    final dio = Dio();

    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio: dio);


    final authRepository =
    AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);


    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);
    final forgotPasswordUseCase = ForgotPasswordUseCase(authRepository);
    final updatePasswordUseCase = UpdatePasswordUseCase(authRepository);
    final verifyOtpUseCase = VerifyOtpUseCase(authRepository);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(
              loginUseCase: loginUseCase,
              registerUseCase: registerUseCase,
              forgotPasswordUseCase: forgotPasswordUseCase,
              updatePasswordUseCase: updatePasswordUseCase,
              verifyOtpUseCase: verifyOtpUseCase,
            ),
          ),
        ],
    child:  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: WelcomeScreen.routeName,
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
    ));
  }
}



// return MaterialApp(
// debugShowCheckedModeBanner: false,
// initialRoute: SelectFlightView.routeName,
// onGenerateRoute: onGenerateRoute,
// theme: ThemeData(
// fontFamily: 'Poppins',
// scaffoldBackgroundColor: Colors.white,
// ),
// );