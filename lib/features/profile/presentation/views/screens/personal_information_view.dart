import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/profile/presentation/views/widgets/build_input_field.dart';

class PersonalInformationScreen extends StatefulWidget {
  static const routeName = '/personal-information-screen';

  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(20),
            BuildInputField(
              label: 'Name',
              icon: Assets.assetsImagesUserInput,
              placeholder: "kneeDue",
            ),
            verticalSpace(24),
            BuildInputField(
              label: 'Email',
              icon: Assets.assetsImagesMessage,
              placeholder: "kneeDue@untitledui.com",
            ),
            verticalSpace(24),
            // Country Field
            BuildInputField(
              label: 'Country',
              icon: Assets.assetsImagesLocationInput,
              placeholder: "200-298 Clipper St San Francisco",
            ),
            verticalSpace(24),
            // Phone Number Field
            BuildInputField(
              label: 'Phone Number',
              icon: Assets.assetsImagesPhone,
              placeholder: "01283529928",
            ),
          ],
        ),
      ),
    );
  }
}
