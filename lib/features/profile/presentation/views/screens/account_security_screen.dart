import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_navigation_item.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_toggle_item.dart';

class AccountSecurityScreen extends StatefulWidget {
  static const String routeName = '/account-security-screen';
  const AccountSecurityScreen({super.key});

  @override
  _AccountSecurityScreenState createState() => _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends State<AccountSecurityScreen> {
  bool biometricEnabled = false;
  bool faceIdEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Account & Security',
          style: TextStyles.font18DarkBlackNormal,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            verticalSpace(20),
            BuildToggleItem(
              title: 'Biometric ID',
              value: biometricEnabled,
              onChanged: (value) {
                setState(() {
                  biometricEnabled = value;
                });
              },
            ),
            verticalSpace(20),
            BuildToggleItem(
              title: 'Face ID',
              value: faceIdEnabled,
              onChanged: (value) {
                setState(() {
                  faceIdEnabled = value;
                });
              },
            ),
            verticalSpace(40),
            BuildNavigationItem(
              title: 'Device Management',
              subtitle: 'Manage your account on the various devices you own.',
              onTap: () {
                // Navigate to Device Management
              },
            ),
            verticalSpace(20),
            BuildNavigationItem(
              title: 'Deactivate Account',
              subtitle:
                  'Temporarily deactivate your account. Easily reactivate when you\'re ready.',
              onTap: () {
                // Navigate to Deactivate Account
              },
            ),
            verticalSpace(20),
            BuildNavigationItem(
              title: 'Delete Account',
              subtitle:
                  'Permanently remove your account and data from Tripmate. Proceed with caution.',
              titleColor: Colors.red,
              onTap: () {
                _showDeleteAccountDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
            'Are you sure you want to permanently delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle account deletion
                if (kDebugMode) {
                  print('Account deletion confirmed');
                }
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
