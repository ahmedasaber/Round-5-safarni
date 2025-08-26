import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/home/domain/repositories/available_tours_repo.dart';
import 'package:safarni/features/home/domain/repositories/categories_repo.dart';
import 'package:safarni/features/home/domain/repositories/recommendation_repo.dart';
import 'package:safarni/features/home/presentation/cubit/available%20tours/available_tours_cubit.dart';
import 'package:safarni/features/home/presentation/cubit/categories/categories_cubit.dart';
import 'package:safarni/features/home/presentation/cubit/recommendation/recommendations_cubit.dart';
import 'package:safarni/features/home/presentation/views/pages/favorite_view.dart';
import 'package:safarni/features/home/presentation/views/widgets/bottom_navigation_bar.dart';
import 'package:safarni/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = "/home";
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _currentIndex = 0;

  void _onTapSelected (int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeViewBody(),
    FavoriteView(),
    const Center(child: Text("Compare Page", style: TextStyle(fontSize: 20))),
    const Center(child: Text("Maps Page", style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoriesCubit(getIt<CategoriesRepo>())),
        BlocProvider(create: (context) => RecommendationsCubit(getIt<RecommendationRepo>())),
        BlocProvider(create: (context) => AvailableToursCubit(getIt<AvailableToursRepo>())),
      ],
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: ConvexNavBar(onTapSelected: _onTapSelected, currentIndex: _currentIndex,),
      ),
    );
  }
}
