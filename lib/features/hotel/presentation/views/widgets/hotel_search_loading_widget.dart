import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class HotelSearchLoadingWidget extends StatelessWidget {
  const HotelSearchLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBarWidget(),
          verticalSpace(18),
          const Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 14),
                Text('Searching hotels...'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
