import 'package:flutter/material.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/filter_view_body.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  static const routeName = '/filter';
  @override
  Widget build(BuildContext context) {
    return const FilterViewBody();
  }
}
