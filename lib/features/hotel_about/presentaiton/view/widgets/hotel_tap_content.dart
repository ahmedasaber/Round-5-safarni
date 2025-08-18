import 'dart:io';
import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_gallery_content.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_header.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_page.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_searsh_bar.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/reviews_list.dart';

class HotelTabContent extends StatelessWidget {
  final int selectedIndex;
  final List<File> selectedImages;
  final VoidCallback onPickImage;
  final Function(int) onRemoveImage;
  final List<ReviewData> reviews;
  final Function(ReviewData) onReviewAdded;
  final String hotelName;
  final String address;
  final double rating;
  final int reviewsCount;

  const HotelTabContent({
    super.key,
    required this.selectedIndex,
    required this.selectedImages,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.reviews,
    required this.onReviewAdded,
    required this.hotelName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return HotelAboutContent();
      case 1:
        return HotelGalleryContent(
          selectedImages: selectedImages,
          onPickImage: onPickImage,
          onRemoveImage: onRemoveImage,
        );
      case 2:
        return HotelReviewContent(
          reviews: reviews,
          onReviewAdded: onReviewAdded,
          hotelName: hotelName,
          address: address,
          rating: rating,
          reviewsCount: reviewsCount,
        );
      default:
        return HotelAboutContent();
    }
  }
}

// About Tab Content Widget (No changes needed)
class HotelAboutContent extends StatelessWidget {
  const HotelAboutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HotelFeaturesRow(),
        verticalSpace(20),
        HotelDescription(),
      ],
    );
  }
}

// Hotel Features Row Widget (No changes needed)
class HotelFeaturesRow extends StatelessWidget {
  const HotelFeaturesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HotelFeature(image: Assets.assetsImagesBed, text: '3Beds'),
        HotelFeature(image: Assets.assetsImagesBath, text: '2 Bath'),
        HotelFeature(image: Assets.assetsImagesSqrt, text: '1,848 Sqrt'),
      ],
    );
  }
}

class HotelFeature extends StatelessWidget {
  final String image;
  final String text;

  const HotelFeature({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: 24, width: 24),
        horizontalSpace(6),
        Text(text, style: TextStyles.font13LightBlackNormal),
      ],
    );
  }
}

// Hotel Description Widget (No changes needed)
class HotelDescription extends StatelessWidget {
  const HotelDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description', style: TextStyles.font17LightBlackNormal),
          verticalSpace(12),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard du ...',
            style: TextStyles.font14DarkGrayNormal,
          ),
          verticalSpace(8),
          GestureDetector(
            onTap: () {},
            child: Text('Read More', style: TextStyles.font13LightBlueNormal),
          ),
        ],
      ),
    );
  }
}

class HotelReviewContent extends StatelessWidget {
  final List<ReviewData> reviews;
  final Function(ReviewData) onReviewAdded;
  final String hotelName;
  final String address;
  final double rating;
  final int reviewsCount;
  
  const HotelReviewContent({
    super.key,
    required this.reviews,
    required this.onReviewAdded,
    required this.hotelName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewHeader(
          onReviewAdded: onReviewAdded,
          hotelName: hotelName,
          address: address,
          rating: rating,
          reviewsCount: reviewsCount,
        ),
        verticalSpace(16),
        ReviewSearchBar(),
        verticalSpace(16),
        Expanded(
          child: ReviewsList(reviews: reviews),
        ),
      ],
    );
  }
}