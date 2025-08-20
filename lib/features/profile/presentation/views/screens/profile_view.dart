import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/profile/presentation/views/screens/account_security_screen.dart';
import 'package:safarni/features/profile/presentation/views/screens/my_booking_screen.dart';
import 'package:safarni/features/profile/presentation/views/screens/personal_information_view.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_menu_item.dart';
import 'package:safarni/features/profile/presentation/views/widgets/profile_photo_widget.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              verticalSpace(40),
              ProfilePhotoWidget(),
              verticalSpace(16),
              Text('Knee Due', style: TextStyles.font16GrayLighterSemiBold),
              verticalSpace(8),
              const Text(
                'kneedue@gmail.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff6B6E80),
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace(50),
              Expanded(
                child: Column(
                  children: [
                    BuildMenuItem(
                      image: Assets.assetsImagesUser,
                      title: 'Personal info',
                      onTap: () {
                        // Navigate to personal info
                        Navigator.pushNamed(
                          context,
                          PersonalInformationScreen.routeName,
                        );
                      },
                      showArrow: true,
                    ),
                    BuildMenuItem(
                      image: Assets.assetsImagesSecurity,
                      title: 'Account & Security',
                      onTap: () {

                        Navigator.pushNamed(
                          context,
                          AccountSecurityScreen.routeName,
                        );
                      },
                      showArrow: true,
                    ),
                    BuildMenuItem(
                      image: Assets.assetsImagesBooking,
                      title: 'My Booking',
                      onTap: () {
                        Navigator.pushNamed(context, MyBookingScreen.routeName);
                      },
                      showArrow: true,
                    ),
                    BuildMenuItem(
                      image: Assets.assetsImagesLanguage,
                      title: 'App Language',
                      onTap: () {
                        // Navigate to language settings
                      },
                      showArrow: true,
                    ),
                    BuildMenuItem(
                      image: Assets.assetsImagesLogout,
                      title: 'Logout',
                      textColor: Colors.red,
                      showArrow: false,
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: double.infinity,
            height: 170,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Do You Want To Register The Exit Already ?',
                  textAlign: TextAlign.center,
                  style: TextStyles.font18DarkBlackNormal,
                ),
                verticalSpace(10),
                // Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // NO Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: Text(
                        'NO',
                        style: TextStyles.font18DarkBlackNormal,
                      ),
                    ),
                    // Yes Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Handle logout logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logged out successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
