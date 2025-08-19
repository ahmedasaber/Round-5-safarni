import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

// Guest Selection Modal Widget
class GuestSelectionModal extends StatefulWidget {
  const GuestSelectionModal({super.key});

  @override
  State<GuestSelectionModal> createState() => _GuestSelectionModalState();
}

class _GuestSelectionModalState extends State<GuestSelectionModal> {
  int adultsCount = 1;
  int childrenCount = 1;
  int infantsCount = 1;

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

                  // Adults Counter
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

          // Check Out Button
          Container(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Check Out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
void showGuestSelectionModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => GuestSelectionModal(),
  );
}
