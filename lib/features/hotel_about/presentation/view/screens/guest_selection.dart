import 'package:flutter/material.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/services/hotel_api_services.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/data/model/booking_data_model.dart';
import 'package:safarni/features/payment/presentation/views/pages/payment_method_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Guest Selection Modal Widget
class GuestSelectionModal extends StatefulWidget {
  final BookingData bookingData;

  const GuestSelectionModal({super.key, required this.bookingData});

  @override
  State<GuestSelectionModal> createState() => _GuestSelectionModalState();
}

class _GuestSelectionModalState extends State<GuestSelectionModal> {
  int adultsCount = 1;
  int childrenCount = 0;
  int infantsCount = 0;
  bool isLoading = false;

  final HotelApiService _hotelApiService = getIt<HotelApiService>();

  Widget _buildGuestCounter({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyles.font18DarkBlackNormal),
                verticalSpace(4),
                Text(subtitle, style: TextStyles.font14DarkGrayNormal),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: count > 0 ? onDecrement : null,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: count > 0 ? Colors.grey[200] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: count > 0 ? Colors.black87 : Colors.grey[400],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.add, size: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<int?> _getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('user_id') ?? 17; // Default to 17 if not found
    } catch (e) {
      return 17; // Default user ID
    }
  }

  Future<void> _completeBooking() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Validate room ID
      if (widget.bookingData.roomId == null) {
        throw Exception('Room ID is required for booking');
      }

      // Get user ID
      final userId = await _getUserId();
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Create booking request matching API format
      final bookingRequest = BookingRequest(
        userId: userId,
        roomId: widget.bookingData.roomId!,
        checkInDate: widget.bookingData.checkInDate,
        checkOutDate: widget.bookingData.checkOutDate,
        adultsCount: adultsCount,
        childrenCount: childrenCount,
        infantsCount: infantsCount,
        note: widget.bookingData.note,
      );

      // Print booking request for debugging

      // Call the booking API
      final response = await _hotelApiService.bookRoom(bookingRequest);

      // Show success message and navigate
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Room booked successfully! Booking ID: ${response.data.id}',
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        
        // Close the modal first
        Navigator.pop(context);
        
        // Navigate to payment
        Navigator.pushNamed(context, PaymentMethodView.routeName);
      }
    } catch (e) {

      // Parse error message
      String errorMessage = 'Booking failed: Unknown error';

      final errorString = e.toString();
      if (errorString.contains('This room is not available for the selected dates')) {
        errorMessage = 'This room is not available for the selected dates. Please choose different dates.';
      } else if (errorString.contains('500')) {
        errorMessage = 'Server error occurred. Please try again later.';
      } else if (errorString.contains('Network error')) {
        errorMessage = 'Network connection problem. Please check your internet connection.';
      } else if (errorString.contains('Room ID is required')) {
        errorMessage = 'Room information is missing. Please try again.';
      } else if (errorString.contains('Exception: ')) {
        errorMessage = errorString.split('Exception: ').last;
      } else {
        errorMessage = errorString;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _completeBooking(),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  verticalSpace(20),

                  // Debug info
                  if (widget.bookingData.roomId != null)
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Text(
                        'Room ID: ${widget.bookingData.roomId}\nCheck-in: ${widget.bookingData.checkInDate}\nCheck-out: ${widget.bookingData.checkOutDate}',
                        style: TextStyle(fontSize: 12, color: Colors.blue[800]),
                      ),
                    ),

                  // Adults Counter (minimum 1)
                  _buildGuestCounter(
                    title: 'Adults',
                    subtitle: 'Ages 18 Or Above',
                    count: adultsCount,
                    onIncrement: () {
                      setState(() {
                        adultsCount++;
                      });
                    },
                    onDecrement: () {
                      if (adultsCount > 1) {
                        setState(() {
                          adultsCount--;
                        });
                      }
                    },
                  ),

                  // Children Counter
                  _buildGuestCounter(
                    title: 'Children',
                    subtitle: 'Ages 2-17',
                    count: childrenCount,
                    onIncrement: () {
                      setState(() {
                        childrenCount++;
                      });
                    },
                    onDecrement: () {
                      if (childrenCount > 0) {
                        setState(() {
                          childrenCount--;
                        });
                      }
                    },
                  ),

                  // Infants Counter
                  _buildGuestCounter(
                    title: 'Infants',
                    subtitle: 'Under Ages 2',
                    count: infantsCount,
                    onIncrement: () {
                      setState(() {
                        infantsCount++;
                      });
                    },
                    onDecrement: () {
                      if (infantsCount > 0) {
                        setState(() {
                          infantsCount--;
                        });
                      }
                    },
                  ),

                  Spacer(),
                ],
              ),
            ),
          ),

          // Complete Booking Button
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _completeBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Complete Booking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          verticalSpace(30),
        ],
      ),
    );
  }
}

// Function to show guest selection modal
void showGuestSelectionModal(BuildContext context, BookingData bookingData) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => GuestSelectionModal(bookingData: bookingData),
  );
}