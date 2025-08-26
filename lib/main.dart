import 'dart:async';
import 'package:flutter/material.dart';
import 'core/services/dio_factory.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'package:safarni/core/helpers/token_manger.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'package:safarni/core/services/bloc_observer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/core/utils/on_generate_routes.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/verify_otp_usecase.dart';
import 'features/home/presentation/views/pages/home_view.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/domain/usecases/update_password_usecase.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:safarni/features/splash/presentation/pages/splash_page.dart';
import 'package:safarni/features/auth/presentation/pages/get_start_page.dart';


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

      try {
        await Hive.initFlutter();
        await Hive.openBox('favorites');
        final searchHistoryBox = await Hive.openBox<String>('searchHistory');
        setupGetIt(searchHistoryBox);
      } catch (e) {
        debugPrint('Hive initialization failed: $e');
      }

      runApp(const SafarniApp());
    },
    (error, stack) {
      debugPrint('App Error: $error');
      debugPrint('Stack: $stack');
    },
  );
}

class SafarniApp extends StatefulWidget {
  const SafarniApp({super.key});

  @override
  State<SafarniApp> createState() => _SafarniAppState();
}

class _SafarniAppState extends State<SafarniApp> {
  String? _initialRoute;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determineInitialRoute();
  }

  // ✅ دالة آمنة لتحديد الصفحة الأولى
  Future<void> _determineInitialRoute() async {
    try {
      // انتظار قصير للتأكد من أن كل شيء جاهز
      await Future.delayed(const Duration(milliseconds: 100));

      final isLoggedIn = await TokenManager.hasToken();
      debugPrint('🔐 Token check: isLoggedIn = $isLoggedIn');

      setState(() {
        _initialRoute = isLoggedIn
            ? HomeView.routeName
            : GetStartedPage.routeName;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('❌ Token check error: $e');
      setState(() {
        _initialRoute = GetStartedPage.routeName;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // أثناء التحميل، أظهر splash screen
    if (_isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // بعد التحميل، أظهر التطبيق الرئيسي
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            // ✅ استخدام DioFactory بدلاً من إنشاء Dio جديد
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
            initialRoute: _initialRoute ?? WelcomeScreen.routeName,
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
