import 'dart:io';
import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_bottom_section.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_header_section.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_tabs_section.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/hotel_tap_content.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_page.dart';

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
  });

  @override
  State<HotelContentSection> createState() => _HotelContentSectionState();
}

class _HotelContentSectionState extends State<HotelContentSection> {
  List<ReviewData> reviews = [];

  void _addReview(ReviewData reviewData) {
    setState(() {
      reviews.insert(0, reviewData); // Add new review at the beginning
    });

    // Show success message
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
              reviewsCount:
                  widget.reviewsCount + reviews.length, // Updated count
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
            // Price and Book Button
            HotelBottomSection(price: widget.price),
          ],
        ),
      ),
    );
  }
}
