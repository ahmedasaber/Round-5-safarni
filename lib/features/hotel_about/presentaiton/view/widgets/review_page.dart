import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'dart:io';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';




// Add Review Modal Widget
class AddReviewModal extends StatefulWidget {
  final String hotelName;
  final String address;
  final double rating;
  final int reviewsCount;
  final Function(ReviewData) onReviewAdded;

  const AddReviewModal({
    super.key,
    required this.hotelName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.onReviewAdded,
  });

  @override
  State<AddReviewModal> createState() => _AddReviewModalState();
}

class _AddReviewModalState extends State<AddReviewModal> {
  final _reviewController = TextEditingController();
  final _nameController = TextEditingController();
  int _selectedRating = 5;
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Image Source'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 1920,
          maxHeight: 1080,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _selectedImages.add(File(image.path));
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _submitReview() {
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your review'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final reviewData = ReviewData(
      userName: _nameController.text.trim().isEmpty
          ? 'Anonymous User'
          : _nameController.text.trim(),
      rating: _selectedRating,
      reviewText: _reviewController.text.trim(),
      date: DateTime.now(),
      images: List.from(_selectedImages),
    );

    widget.onReviewAdded(reviewData);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header section with hotel info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Discount badge and rating
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffEBF5FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '20%Off',
                        style: TextStyles.font12DarkBlueNormal,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.assetsImagesStar,
                            height: 16,
                            width: 16,
                          ),
                          horizontalSpace(4),
                          Text(
                            '4.5 (357 Reviews)',
                            style: TextStyles.font12DarkGrayNormal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                // Hotel name and address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.hotelName,
                        style: TextStyles.font20LightBlackNormal,
                      ),
                    ),
                    verticalSpace(4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.address,
                        style: TextStyles.font12DarkGrayNormal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(12),
                  Divider(height: 1, color: Colors.grey[300]),
                  verticalSpace(12),

                  // Rating Section
                  Center(
                    child: Text(
                      'Your Over Rating Of This Product',
                      style: TextStyles.font14DarkGrayNormal,
                    ),
                  ),

                  verticalSpace(16),

                  // Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.star,
                            color: index < _selectedRating
                                ? Colors.amber
                                : Colors.grey[300],
                            size: 50,
                          ),
                        ),
                      );
                    }),
                  ),
                  verticalSpace(32),
                  // Review Text Section
                  Text(
                    'Add detailed review',
                    style: TextStyles.font17LightBlackNormal,
                  ),
                  verticalSpace(12),
                  // Review Text Field
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _reviewController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        hintText: 'Enter here',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),

                  verticalSpace(24),

                  // Add Photos Section
                  GestureDetector(
                    onTap: _pickImage,
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.assetsImagesCamera,
                          height: 20,
                          width: 20,
                        ),
                        horizontalSpace(4),
                        Text(
                          'add Photo',
                          style: TextStyles.font15DarkBlueNormal,
                        ),
                      ],
                    ),
                  ),

                  // Selected Images
                  if (_selectedImages.isNotEmpty) ...[
                    verticalSpace(16),
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _selectedImages[index],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],

                  verticalSpace(32),
                ],
              ),
            ),
          ),

          // Submit Button
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E4BC6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to show the modal
void showAddReviewModal(
  BuildContext context, {
  required String hotelName,
  required String address,
  required double rating,
  required int reviewsCount,
  required Function(ReviewData) onReviewAdded,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddReviewModal(
      hotelName: hotelName,
      address: address,
      rating: rating,
      reviewsCount: reviewsCount,
      onReviewAdded: onReviewAdded,
    ),
  );
}
