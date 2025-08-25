import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/booking_flight/presentation/view/boarding_pass_view.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/flight_booking_cubit.dart';
import '../cubit/flight_booking_state.dart';

class ChooseSeatView extends StatefulWidget {
  const ChooseSeatView({super.key});
  static const routeName = "/choose_seat";

  @override
  State<ChooseSeatView> createState() => _ChooseSeatViewState();
}

class _ChooseSeatViewState extends State<ChooseSeatView> {
  int? selectedSeatNumber;

  @override
  void initState() {
    super.initState();
    // 👇 نجيب الـ seats عند فتح الصفحة (مثلا flightId = "1")
    context.read<SeatCubit>().fetchSeats("1");
  }

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
          onPressed: () => Navigator.pop(context),
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
              child: BlocBuilder<SeatCubit, SeatState>(
                builder: (context, state) {
                  if (state is SeatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SeatLoaded) {
                    final seats = state.seats;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 60,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: seats.length,
                      itemBuilder: (context, index) {
                        final seat = seats[index];
                        final isSelected = selectedSeatNumber == seat.seatNumber;
                        return _buildSeat(seat.seatNumber, seat.isAvailable, isSelected);
                      },
                    );
                  } else if (state is SeatError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  return const SizedBox();
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildPricingSection(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedSeatNumber != null
                    ? () => Navigator.of(context).pushReplacementNamed(BoardingPassView.routeName)
                    : null,
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
        _buildLegendItem(AppColors.primaryColor, 'Available'),
        _buildLegendItem(Colors.green, 'Selected'),
        _buildLegendItem(Colors.grey[400]!, 'Unavailable'),
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

    final textColor = isSelected || isAvailable ? Colors.white : Colors.black;

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
        _buildPriceRow('Your Seat', selectedSeatNumber != null ? '$selectedSeatNumber' : '--'),
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
