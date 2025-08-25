  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:safarni/features/hotel_about/presentation/view/widgets/gallery_image_item.dart';

  class GalleryGrid extends StatelessWidget {
    final List<String> galleryImages;
    final List<File> selectedImages;
    final Function(int) onRemoveImage;

    const GalleryGrid({
      super.key,
      required this.galleryImages,
      required this.selectedImages,
      required this.onRemoveImage,
    });

    @override
    Widget build(BuildContext context) {
      int totalImages = galleryImages.length + selectedImages.length;

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: totalImages,
        itemBuilder: (context, index) {
          if (index < galleryImages.length) {
            return GalleryImageItem(
              imageProvider: AssetImage(galleryImages[index]),
            );
          } else {
            int selectedImageIndex = index - galleryImages.length;
            return GalleryImageItem(
              imageProvider: FileImage(selectedImages[selectedImageIndex]),
              onRemove: () => onRemoveImage(selectedImageIndex),
              showRemoveButton: true,
            );
          }
        },
      );
    }
  }