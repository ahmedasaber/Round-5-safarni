import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/gallery_grid.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/gallery_header.dart';

class HotelGalleryContent extends StatelessWidget {
  final List<File> selectedImages;
  final VoidCallback onPickImage;
  final Function(int) onRemoveImage;

  const HotelGalleryContent({
    super.key,
    required this.selectedImages,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    List<String> galleryImages = [
      Assets.assetsImagesHotel1,
      Assets.assetsImagesHotel2,
      Assets.assetsImagesHotel3,
      Assets.assetsImagesHotel1,
      Assets.assetsImagesHotel2,
      Assets.assetsImagesHotel3,
      
    ];

    int totalImages = galleryImages.length + selectedImages.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gallery Header
        GalleryHeader(totalImages: totalImages, onPickImage: onPickImage),

        verticalSpace(16),

        // Gallery Grid
        Expanded(
          child: GalleryGrid(
            galleryImages: galleryImages,
            selectedImages: selectedImages,
            onRemoveImage: onRemoveImage,
          ),
        ),
      ],
    );
  }
}
