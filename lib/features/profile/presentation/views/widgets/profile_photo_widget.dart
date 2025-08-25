import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_assets.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF2E4BC6),
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              Assets.assetsImagesAvatar,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[200]);
              },
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          right: 4,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              Assets.assetsImagesCameraProfile,
              width: 16,
              height: 16,
            ),
          ),
        ),
      ],
    );
  }
}
