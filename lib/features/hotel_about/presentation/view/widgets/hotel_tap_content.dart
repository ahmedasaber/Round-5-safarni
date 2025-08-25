import 'dart:io';
import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_gallery_content.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/review_header.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/review_searsh_bar.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/reviews_list.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/safe_network_image.dart';

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
  final RoomDetailModel? roomDetail; // أضف هذا الباراميتر

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
    this.roomDetail, // أضف هذا الباراميتر
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return HotelAboutContent(
          roomDetail: roomDetail,
        ); // مرر الـ roomDetail هنا
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
        return HotelAboutContent(
          roomDetail: roomDetail,
        ); // مرر الـ roomDetail هنا أيضاً
    }
  }
}

class HotelAboutContent extends StatelessWidget {
  final RoomDetailModel? roomDetail;
  const HotelAboutContent({super.key, this.roomDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelFeaturesRow(roomDetail: roomDetail),
          verticalSpace(20),
          HotelDescription(roomDetail: roomDetail),
        ],
      ),
    );
  }
}

class HotelFeaturesRow extends StatelessWidget {
  final RoomDetailModel? roomDetail;
  const HotelFeaturesRow({super.key, this.roomDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HotelFeature(
          image: Assets.assetsImagesBed,
          text: '${roomDetail?.capacity ?? 0} Beds', // أضف default value
        ),
        HotelFeature(
          image: Assets.assetsImagesBath,
          text: '${roomDetail?.bathroomNumber ?? 0} Bath', // أضف default value
        ),
        HotelFeature(
          image: Assets.assetsImagesSqrt,
          text: '${roomDetail?.area ?? 0} Sqrt', // أضف default value
        ),
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
        _buildImage(),
        horizontalSpace(6),
        Text(text, style: TextStyles.font13LightBlackNormal),
      ],
    );
  }

  Widget _buildImage() {
    if (image.startsWith('http')) {
      return SafeNetworkImage(imageUrl: image, width: 24, height: 24);
    } else {
      return Image.asset(
        image,
        height: 24,
        width: 24,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 24,
            height: 24,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              size: 16,
              color: Colors.grey[400],
            ),
          );
        },
      );
    }
  }
}

class HotelDescription extends StatelessWidget {
  final RoomDetailModel? roomDetail;
  const HotelDescription({super.key, this.roomDetail});

  @override
  Widget build(BuildContext context) {
    final description =
        roomDetail?.description ??
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard du ...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyles.font17LightBlackNormal),
        SizedBox(height: 12),
        Text(
          (roomDetail?.description != null &&
                  roomDetail!.description.isNotEmpty)
              ? roomDetail!.description
              : description,
          style: TextStyles.font14DarkGrayNormal,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {},
          child: Text('Read More', style: TextStyles.font13LightBlueNormal),
        ),
      ],
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
        Expanded(child: ReviewsList(reviews: reviews)),
      ],
    );
  }
}
