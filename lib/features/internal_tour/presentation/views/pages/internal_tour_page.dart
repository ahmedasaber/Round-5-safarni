import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_list_view.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_search_bar.dart';

class InternalTourPage extends StatelessWidget {
  const InternalTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(children: [ToursSearchBar(), ToursListView()]),
      ),
    );
  }
}
