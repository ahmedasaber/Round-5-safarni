import 'package:flutter/material.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';
import 'package:safarni/features/search/presentation/view/pages/search_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());
     case ResultView.routeName:
      return MaterialPageRoute(builder: (_) => const ResultView());
    case FilterView.routeName:
      return MaterialPageRoute(builder: (_) => const FilterView());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text('Unknown Route')),
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}