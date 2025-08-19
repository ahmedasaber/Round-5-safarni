import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';

class GalleryHeader extends StatelessWidget {
  final int totalImages;
  final VoidCallback onPickImage;

  const GalleryHeader({
    super.key,
    required this.totalImages,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Gallery', style: TextStyles.font16LightBlackNormal),
        horizontalSpace(2),
        Text("($totalImages)", style: TextStyles.font12DarkBlueNormal),
        Spacer(),
        GestureDetector(
          onTap: onPickImage,
          child: Row(
            children: [
              Image.asset(Assets.assetsImagesCamera, height: 20, width: 20),
              horizontalSpace(4),
              Text('add Photo', style: TextStyles.font15DarkBlueNormal),
            ],
          ),
        ),
      ],
    );
  }
}
