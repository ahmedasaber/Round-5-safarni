import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/data/model/booking_data_model.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/guest_selection.dart';

class BookHotelModal extends StatefulWidget {
  final String hotelName;
  final String address;
  final double rating;
  final int reviewsCount;
  final String price;
  final int? roomId;

  const BookHotelModal({
    super.key,
    required this.hotelName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    this.roomId,
  });

  @override
  State<BookHotelModal> createState() => _BookHotelModalState();
}

class _BookHotelModalState extends State<BookHotelModal> {
  final TextEditingController _noteController = TextEditingController();
  String selectedCheckInDay = 'Today';
  String selectedCheckOutDay = '';

  late final List<Map<String, String>> checkInOptions;
  late final List<Map<String, String>> checkOutOptions;

  String _selectedCheckInDate = '';
  String _selectedCheckOutDate = '';

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    final now = DateTime.now();

    // Check-in options (today and next 2 days)
    checkInOptions = [
      {
        'day': 'Today',
        'date': _formatDate(now),
        'display': _getDisplayDate(now),
      },
      {
        'day': _getDayName(now.add(Duration(days: 1))),
        'date': _formatDate(now.add(Duration(days: 1))),
        'display': _getDisplayDate(now.add(Duration(days: 1))),
      },
      {
        'day': _getDayName(now.add(Duration(days: 2))),
        'date': _formatDate(now.add(Duration(days: 2))),
        'display': _getDisplayDate(now.add(Duration(days: 2))),
      },
    ];

    // Check-out options (3-7 days from now)
    final checkOutStart = now.add(Duration(days: 3));
    checkOutOptions = [
      {
        'day': _getDayName(checkOutStart),
        'date': _formatDate(checkOutStart),
        'display': _getDisplayDate(checkOutStart),
      },
      {
        'day': _getDayName(checkOutStart.add(Duration(days: 1))),
        'date': _formatDate(checkOutStart.add(Duration(days: 1))),
        'display': _getDisplayDate(checkOutStart.add(Duration(days: 1))),
      },
      {
        'day': _getDayName(checkOutStart.add(Duration(days: 2))),
        'date': _formatDate(checkOutStart.add(Duration(days: 2))),
        'display': _getDisplayDate(checkOutStart.add(Duration(days: 2))),
      },
    ];

    // Set default selected dates
    _selectedCheckInDate = checkInOptions[0]['date']!;
    _selectedCheckOutDate = checkOutOptions[0]['date']!;
    selectedCheckOutDay = checkOutOptions[0]['day']!;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _getDisplayDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _continueBooking() {
    // Validate room ID
    if (widget.roomId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Room information is missing. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Validate dates
    final checkInDate = DateTime.parse(_selectedCheckInDate);
    final checkOutDate = DateTime.parse(_selectedCheckOutDate);

    if (checkOutDate.isBefore(checkInDate) ||
        checkOutDate.isAtSameMomentAs(checkInDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check-out date must be after check-in date.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Create booking data with room ID
    final bookingData = BookingData(
      roomId: widget.roomId!,
      checkInDate: _selectedCheckInDate,
      checkOutDate: _selectedCheckOutDate,
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );

    // Print booking data for debugging

    // Navigate to guest selection with booking data
    Navigator.pop(context); // Close current modal
    showGuestSelectionModal(context, bookingData);
  }

  Widget _buildDateSelector({
    required List<Map<String, String>> options,
    required String selectedDay,
    required Function(String day, String date) onSelected,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((option) {
        final isSelected = selectedDay == option['day'];
        return GestureDetector(
          onTap: () {
            onSelected(option['day']!, option['date']!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xffEBF5FF) : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  option['day']!,
                  style: TextStyle(
                    color: isSelected ? AppColors.darkBlue : Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(4),
                Text(
                  option['display']!,
                  style: TextStyle(
                    color: isSelected ? AppColors.darkBlue : Colors.black87,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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

                    // Debug info (remove in production)
                    if (widget.roomId != null)
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.green[700],
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Room ID: ${widget.roomId}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

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
                    Text(
                      widget.hotelName,
                      style: TextStyles.font20LightBlackNormal,
                    ),
                    verticalSpace(4),
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
                    _buildDateSelector(
                      options: checkInOptions,
                      selectedDay: selectedCheckInDay,
                      onSelected: (day, date) {
                        setState(() {
                          selectedCheckInDay = day;
                          _selectedCheckInDate = date;
                        });
                      },
                    ),
                    verticalSpace(24),

                    // Check Out Section
                    Text('Check Out', style: TextStyles.font16LightBlackNormal),
                    verticalSpace(12),
                    _buildDateSelector(
                      options: checkOutOptions,
                      selectedDay: selectedCheckOutDay,
                      onSelected: (day, date) {
                        setState(() {
                          selectedCheckOutDay = day;
                          _selectedCheckOutDate = date;
                        });
                      },
                    ),
                    verticalSpace(24),

                    // Note To Owner Section
                    Text(
                      'Note To Owner',
                      style: TextStyles.font17LightBlackNormal,
                    ),
                    verticalSpace(12),
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
  int? roomId,
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
      roomId: roomId,
    ),
  );
}
