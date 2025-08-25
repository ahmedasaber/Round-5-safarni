import 'package:flutter/material.dart';
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
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: ConvexNavBar(onTapSelected: _onTapSelected, currentIndex: _currentIndex,),
    );
  }
}
