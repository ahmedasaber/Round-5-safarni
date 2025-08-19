import 'package:flutter/material.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_list_view_item.dart';

class ToursListView extends StatelessWidget {
  const ToursListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ToursListViewItem();
        },
      ),
    );
  }
}
