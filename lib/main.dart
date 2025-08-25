import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/on_generate_routes.dart';


import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';



import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/domain/usecases/update_password_usecase.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';


import 'features/auth/presentaion/cubit/auth_cubit.dart';
import 'features/splash/presentaion/pages/splash_page.dart';

void main(){
  runApp(SafarniApp());
}


class SafarniApp extends StatelessWidget {
  const SafarniApp({super.key});

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
            ),
          );
        },
      ),
    );
  }
}
