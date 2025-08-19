import 'package:flutter/material.dart';
import 'package:safarni/core/common/widgets/elevated_button.dart';
import 'package:safarni/features/booking_flight/presentation/view/boarding_pass_view.dart';
import '../../../../core/utils/app_colors.dart';

class ChooseSeatView extends StatefulWidget {
  const ChooseSeatView({super.key});
  static const routeName = "/choose_seat";

  @override
  State<ChooseSeatView> createState() => _ChooseSeatViewState();
}

class _ChooseSeatViewState extends State<ChooseSeatView> {
  int? selectedSeatNumber;

  // The list of seat numbers, including nulls for the empty spaces in the layout
  final List<int?> seats = [
    1, 2, null, 3, 4, 5,
    6, 7, null, 8, 9, 10,
    11, 12, null, 13, 14, 15,
    16, 17, null, 18, 19, 20,
    21, 22, null, 23, 24, 25,
    26, 27, null, 28, 29, 30,
  ];

  // A list of seat numbers that are unavailable
  final List<int> unavailableSeats = [4, 5, 8, 9, 10, 16, 17, 20, 24, 25, 26, 28, 29];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Seats",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildLegend(),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 60,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: seats.length,
                itemBuilder: (context, index) {
                  final seatNumber = seats[index];
                  if (seatNumber == null) {
                    return const SizedBox.shrink(); // Empty space for aisle
                  }
                  final isUnavailable = unavailableSeats.contains(seatNumber);
                  final isSelected = selectedSeatNumber == seatNumber;

                  return _buildSeat(seatNumber, !isUnavailable, isSelected);
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildPricingSection(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {Navigator.of(context).pushReplacementNamed(BoardingPassView.routeName);},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLegendItem(Colors.blue[800]!, 'Available'),
        _buildLegendItem(Colors.green, 'Selected'),
        _buildLegendItem(Colors.grey[400]!, 'Un available'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  Widget _buildSeat(int seatNumber, bool isAvailable, bool isSelected) {
    final color = isSelected
        ? Colors.green
        : isAvailable
        ? AppColors.primaryColor
        : Colors.grey[400];

    // هنا بحدد لون الرقم
    final textColor = isSelected
        ? Colors.white
        : isAvailable
        ? Colors.white
        : Colors.black; // لو الكرسي رمادي يبقى الرقم أسود

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          setState(() {
            selectedSeatNumber = isSelected ? null : seatNumber;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildPricingSection() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 10),
        _buildPriceRow('Ticket price', '150.00\$'),
        const SizedBox(height: 10),
        _buildPriceRow('Total Price', '150.00\$'),
        const SizedBox(height: 10),
        _buildPriceRow('your Seat', selectedSeatNumber != null ? '$selectedSeatNumber' : '--'),
        const Divider(),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
      ],
    );
  }
}