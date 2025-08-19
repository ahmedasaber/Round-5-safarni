import 'package:flutter/material.dart';

class BudgetRangeView extends StatefulWidget {
  const BudgetRangeView({super.key});

  @override
  State<BudgetRangeView> createState() => _BudgetRangeViewState();
}

class _BudgetRangeViewState extends State<BudgetRangeView> {
  RangeValues budgetRange = RangeValues(2125, 6375);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/budget-range-imag.png', width: double.infinity, fit: BoxFit.cover,),
        Positioned.fill(
          bottom: -80,
          child: RangeSlider(
            activeColor: Color(0xff3f83f8),
            inactiveColor: Color(0xffA4CAFE),
            values: budgetRange,
            min: 0,
            max: 8500,
            divisions: 100,
            labels: RangeLabels(
              "\$${budgetRange.start.toInt()}",
              "\$${budgetRange.end.toInt()}",
            ),
            onChanged: (RangeValues values) {
              setState(() {
                budgetRange = values;
              });
            },
          ),
        )
      ],
    );
  }
}
