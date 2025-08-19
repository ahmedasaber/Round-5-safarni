import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/guest_selection.dart';

// Booking Modal Widget
class BookHotelModal extends StatefulWidget {
  final String hotelName;
  final String address;
  final double rating;
  final int reviewsCount;
  final String price;

  const BookHotelModal({
    super.key,
    required this.hotelName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.price,
  });

  @override
  State<BookHotelModal> createState() => _BookHotelModalState();
}

class _BookHotelModalState extends State<BookHotelModal> {
  final TextEditingController _noteController = TextEditingController();
  String selectedCheckInDay = 'Today';
  String selectedCheckInDate = '4 Oct';

  String selectedCheckOutDay = 'Sun';
  String selectedCheckOutDate = '3 Nov';

  final List<Map<String, String>> checkInOptions = [
    {'day': 'Today', 'date': '4 Oct'},
    {'day': 'Tue', 'date': '5 Oct'},
    {'day': 'Wed', 'date': '6 Oct'},
  ];

  final List<Map<String, String>> checkOutOptions = [
    {'day': 'Sun', 'date': '3 Nov'},
    {'day': 'Mon', 'date': '4 Nov'},
    {'day': 'Wed', 'date': '5 Nov'},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _continueBooking() {
    showGuestSelectionModal(context);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking request submitted successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    // Hotel Info
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
                            '10%Off',
                            style: TextStyles.font12DarkBlueNormal,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${widget.rating}(${widget.reviewsCount} Reviews)',
                          style: TextStyles.font12DarkGrayNormal,
                        ),
                      ],
                    ),
                    verticalSpace(12),
                    // Hotel name
                    Text(
                      widget.hotelName,
                      style: TextStyles.font20LightBlackNormal,
                    ),
                    verticalSpace(4),
                    // Address
                    Text(
                      widget.address,
                      style: TextStyles.font12DarkGrayNormal,
                    ),
                    verticalSpace(16),
                    Divider(color: Colors.grey[300]),
                    verticalSpace(16),
                    Center(
                      child: Text(
                        'Book Hotel',
                        style: TextStyles.font20DarkBlueNormal,
                      ),
                    ),
                    verticalSpace(24),
                    // Check In Section
                    Text('Check In', style: TextStyles.font16LightBlackNormal),
                    verticalSpace(12),
                    // Check In Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: checkInOptions.map((option) {
                        final isSelected = selectedCheckInDay == option['day'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCheckInDay = option['day']!;
                              selectedCheckInDate = option['date']!;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 35,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xffEBF5FF)
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.grey[300]!,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  option['day']!,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.darkBlue
                                        : Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                verticalSpace(4),
                                Text(
                                  option['date']!,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.darkBlue
                                        : Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    verticalSpace(24),
                    // Check Out Section
                    Text(
                      'Check Out',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    verticalSpace(12),

                    // Check Out Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: checkOutOptions.map((option) {
                        final isSelected = selectedCheckOutDay == option['day'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCheckOutDay = option['day']!;
                              selectedCheckOutDate = option['date']!;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 35,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xffEBF5FF)
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.grey[300]!,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  option['day']!,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.darkBlue
                                        : Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                verticalSpace(4),
                                Text(
                                  option['date']!,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.darkBlue
                                        : Colors.black87,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    verticalSpace(24),
                    // Note To Owner Section
                    Text(
                      'Note To Owner',
                      style: TextStyles.font17LightBlackNormal,
                    ),
                    verticalSpace(12),
                    // Note Text Field
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: _noteController,
                        maxLines: 3,
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
                    verticalSpace(32),
                  ],
                ),
              ),
            ),
          ),

          // Continue Button
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continueBooking,
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
                  'Continue',
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
void showBookHotelModal(
  BuildContext context, {
  required String hotelName,
  required String address,
  required double rating,
  required int reviewsCount,
  required String price,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BookHotelModal(
      hotelName: hotelName,
      address: address,
      rating: rating,
      reviewsCount: reviewsCount,
      price: price,
    ),
  );
}
