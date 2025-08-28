import 'dart:async';
import 'package:flutter/material.dart';
import 'core/services/dio_factory.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'package:safarni/core/services/bloc_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/core/utils/on_generate_routes.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/domain/usecases/update_password_usecase.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:safarni/features/splash/presentation/pages/splash_page.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    Bloc.observer = BlocObserverService();

    await Hive.initFlutter();
    await Hive.openBox('favorites');
    final searchHistoryBox = await Hive.openBox<String>('searchHistory');
    setupGetIt(searchHistoryBox);

    runApp(const SafarniApp());
  }, (error, stackTrace) {});
}

class SafarniApp extends StatelessWidget {
  const SafarniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final dio = DioFactory.getDio();
            final authRemoteDataSource = AuthRemoteDataSourceImpl(dio: dio);
            final authRepository = AuthRepositoryImpl(
              remoteDataSource: authRemoteDataSource,
            );

            return AuthCubit(
              loginUseCase: LoginUseCase(authRepository),
              registerUseCase: RegisterUseCase(authRepository),
              forgotPasswordUseCase: ForgotPasswordUseCase(authRepository),
              updatePasswordUseCase: UpdatePasswordUseCase(authRepository),
              verifyOtpUseCase: VerifyOtpUseCase(authRepository),
            );
          },
        ),
      ],
      child: ScreenUtilInit(
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
              appBarTheme: const AppBarTheme(
                scrolledUnderElevation: 0,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
