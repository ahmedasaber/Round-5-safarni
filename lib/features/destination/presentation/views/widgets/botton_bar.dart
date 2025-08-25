import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/payment/presentation/views/pages/payment_method_view.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total price', style: TextStyle(color: Colors.black)),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '\$150.00',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text('/per person.', style: TextStyle(color: AppColors.softGrey,fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {Navigator.of(context).pushReplacementNamed(PaymentMethodView.routeName);},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor, // A deep blue color
              padding: EdgeInsets.symmetric(horizontal: TextStyles.spaceBtwSections, vertical: TextStyles.spaceBtwItems - 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg - 2),
              ),
            ),
            child: Text('Book Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
