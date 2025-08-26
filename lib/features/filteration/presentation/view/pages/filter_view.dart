import 'package:flutter/material.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/filter_view_body.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key, required this.query});

  static const routeName = '/filter';
  final String query;
  @override
  Widget build(BuildContext context) {
    return FilterViewBody(query: query);
  }
}
