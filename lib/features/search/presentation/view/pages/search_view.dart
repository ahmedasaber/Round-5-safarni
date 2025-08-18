import 'package:flutter/material.dart';
import 'package:safarni/features/search/presentation/view/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const routeName = '/search';
  @override
  Widget build(BuildContext context) {
    return SearchViewBody();
  }
}
