import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/common/widgets/elevated_button.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/booking_flight/presentation/view/choose_seat_view.dart';
import 'package:safarni/features/booking_flight/presentation/view/widgets/top_section.dart';

import '../cubit/flight_booking_cubit.dart';
import '../cubit/flight_booking_state.dart';

class SelectFlightView extends StatefulWidget {
  const SelectFlightView({super.key});

  static const routeName = "/flight_select";

  @override
  State<SelectFlightView> createState() => _SelectFlightViewState();
}

class _SelectFlightViewState extends State<SelectFlightView> {
  DateTime? departureDate = DateTime(2025, 12, 16);
  DateTime? returnDate = DateTime(2025, 1, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header image
          const TopSection(),

          // Date buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: _buildDateButton(
                    "${departureDate!.day}/${departureDate!.month}/${departureDate!.year}",
                    icon: Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDateButton(
                    "${returnDate!.day}/${returnDate!.month}/${returnDate!.year}",
                    icon: Icons.calendar_today,
                  ),
                ),
              ],
            ),
          ),

          // Flight list with Bloc
          Expanded(
            child: BlocConsumer<FlightBookingCubit, FlightBookingState>(
              listener: (context, state) {
                if (state is FlightBookingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is FlightBookingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FlightBookingLoaded) {
                  final flights = state.flights;
                  if (flights.isEmpty) {
                    return const Center(child: Text("No flights found"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: flights.length,
                    itemBuilder: (context, index) {
                      final flight = flights[index];
                      return _buildFlightCard(
                        departureTime: flight.departureTime,
                        arrivalTime: flight.arrivalTime,
                        departureAirportCode: flight.from,
                        arrivalAirportCode: flight.to,
                        duration: flight.duration,
                        airline: flight.airline,
                        price: "\$${flight.price}",
                      );
                    },
                  );
                } else if (state is FlightBookingError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Error: ${state.message}"),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            // إعادة محاولة البحث
                            context.read<FlightBookingCubit>().retryLastSearch();
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: Text("Search for flights"));
              },
            ),
          ),

          // Continue button
          Padding(
            padding: const EdgeInsets.all(TextStyles.defaultSpace - 8),
            child: AppElevatedButton(
              buttonTitle: 'Continue',
              primaryButton: true,
              onPressed: () => Navigator.of(context).pushReplacementNamed(
                ChooseSeatView.routeName,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateButton(String text, {required IconData icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: TextStyles.fontSizeSm,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightCard({
    required String departureTime,
    required String arrivalTime,
    required String departureAirportCode,
    required String arrivalAirportCode,
    required String duration,
    required String airline,
    required String price,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(TextStyles.defaultSpace - 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg + 4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          // First row: Times, duration, and airport codes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    departureTime,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    departureAirportCode,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.flight, size: 24, color: Colors.black),
                  Text(
                    duration,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    arrivalTime,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    arrivalAirportCode,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          // Second row: Airline and price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                airline,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                price,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
