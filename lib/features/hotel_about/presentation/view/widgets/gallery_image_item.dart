import 'package:flutter/material.dart';

class GalleryImageItem extends StatelessWidget {
  final ImageProvider imageProvider;
  final VoidCallback? onRemove;
  final bool showRemoveButton;

  const GalleryImageItem({
    super.key,
    required this.imageProvider,
    this.onRemove,
    this.showRemoveButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        if (showRemoveButton)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
      ],
    );
  }
}