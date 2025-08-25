import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/search/presentation/view/widgets/card_result_item.dart';

class ResultViewBody extends StatelessWidget {
  const ResultViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actionsList: [
          SvgPicture.asset(
            'assets/icons/search-normal.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          SizedBox(width: 33),
          SvgPicture.asset(
            'assets/icons/filter.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Paris ', style: TextStyles.semiBold20),
                  TextSpan(text: '56 Result', style: TextStyles.regular15),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CardResultItem(
                      image: 'assets/images/Double-Dreams-in-Paris.jpg',
                      title: 'Double Dreams in Paris',
                      rate: '4.5 (650)',
                      pickUpAvailable: '5 Days',
                      price: '1050',
                      isFavorite: false,
                    ),
                    CardResultItem(
                      image: 'assets/images/Double-Dreams-in-Paris.jpg',
                      title: 'Double Dreams in Paris',
                      rate: '4.5 (650)',
                      pickUpAvailable: '5 Days',
                      price: '1050',
                      isFavorite: false,
                    ),
                    CardResultItem(
                      image: 'assets/images/Double-Dreams-in-Paris.jpg',
                      title: 'Double Dreams in Paris',
                      rate: '4.5 (650)',
                      pickUpAvailable: '5 Days',
                      price: '1050',
                      isFavorite: false,
                    ),
                    CardResultItem(
                      image: 'assets/images/Double-Dreams-in-Paris.jpg',
                      title: 'Double Dreams in Paris',
                      rate: '4.5 (650)',
                      pickUpAvailable: '5 Days',
                      price: '1050',
                      isFavorite: false,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
