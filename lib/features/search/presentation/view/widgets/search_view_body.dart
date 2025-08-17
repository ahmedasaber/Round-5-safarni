import 'package:flutter/material.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search'),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
