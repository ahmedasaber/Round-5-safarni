import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/services/bloc_observer.dart';
import 'package:safarni/core/utils/on_generate_routes.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';

void main() {
  Bloc.observer = BlocObserverService();
  runApp(const SafarniApp());
}

class SafarniApp extends StatelessWidget {
  const SafarniApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.routeName,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          color: Colors.white
        ),
      ),
    );
  }
}
