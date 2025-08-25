import 'dart:io';
import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_bottom_section.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_header_section.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_tabs_section.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/hotel_tap_content.dart';

class HotelContentSection extends StatefulWidget {
  final String roomName;
  final String address;
  final double rating;
  final int reviewsCount;
  final String price;
  final int selectedTabIndex;
  final Function(int) onTabChanged;
  final List<File> selectedImages;
  final VoidCallback onPickImage;
  final Function(int) onRemoveImage;
  final RoomDetailModel? roomDetail;

  const HotelContentSection({
    super.key,
    required this.roomName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.selectedImages,
    required this.onPickImage,
    required this.onRemoveImage,
    this.roomDetail,
  });

  @override
  State<HotelContentSection> createState() => _HotelContentSectionState();
}

class _HotelContentSectionState extends State<HotelContentSection> {
  List<ReviewData> reviews = [];

  void _addReview(ReviewData reviewData) {
    setState(() {
      reviews.insert(0, reviewData);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Review added successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Print room ID for debugging
    print('🏨 HotelContentSection - Room ID: ${widget.roomDetail?.id}');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            HotelHeaderSection(
              rating: widget.rating,
              reviewsCount: widget.reviewsCount + reviews.length,
              roomName: widget.roomName,
              address: widget.address,
            ),
            verticalSpace(20),
            HotelTabsSection(
              selectedIndex: widget.selectedTabIndex,
              onTabChanged: widget.onTabChanged,
            ),
            verticalSpace(20),
            // Tab Content
            Expanded(
              child: HotelTabContent(
                roomDetail: widget.roomDetail,
                selectedIndex: widget.selectedTabIndex,
                selectedImages: widget.selectedImages,
                onPickImage: widget.onPickImage,
                onRemoveImage: widget.onRemoveImage,
                reviews: reviews,
                onReviewAdded: _addReview,
                hotelName: widget.roomName,
                address: widget.address,
                rating: widget.rating,
                reviewsCount: widget.reviewsCount + reviews.length,
              ),
            ),
            verticalSpace(20),
            // Price and Book Button - مرر الـ room ID من roomDetail
            HotelBottomSection(
              price: widget.price,
              hotelName: widget.roomName,
              address: widget.address,
              rating: widget.rating,
              reviewsCount: widget.reviewsCount + reviews.length,
              roomId: widget.roomDetail?.id, // مرر الـ room ID هنا
            ),
          ],
        ),
      ),
    );
  }
}
