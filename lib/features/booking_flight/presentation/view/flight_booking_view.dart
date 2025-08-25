import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/common/widgets/elevated_button.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/booking_flight/presentation/view/select_flight_view.dart';
import 'package:safarni/features/booking_flight/presentation/view/widgets/passengers_drop_down_menu_form_field.dart';
import 'package:safarni/features/booking_flight/presentation/view/widgets/section_title.dart';
import 'package:safarni/features/booking_flight/presentation/view/widgets/top_section.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/flight_booking_cubit.dart';

class FlightBookingView extends StatefulWidget {
  const FlightBookingView({super.key});

  static const routeName = "/flight_booking";
  @override
  State<FlightBookingView> createState() => _FlightBookingViewState();
}

class _FlightBookingViewState extends State<FlightBookingView> {
  String tripType = "Round Trip";
  String passenger = "1 Passenger";

  final TextEditingController locationController =
  TextEditingController(text: "Montreal,Canada");
  final TextEditingController destinationController =
  TextEditingController(text: "Tokyo,Japan");

  DateTime? departureDate = DateTime(2025, 12, 16);
  DateTime? returnDate = DateTime(2025, 1, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header image
          TopSection(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(TextStyles.defaultSpace - 4),
              child: Column(
                children: [
                  // Trip Type
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 12),
                        tripTypeButton("Round Trip", Icons.sync),
                        const SizedBox(width: 10),
                        tripTypeButton("Multi City", Icons.sync_rounded),
                        const SizedBox(width: 10),
                        tripTypeButton("One Way", CupertinoIcons.arrow_right),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Location
                  SectionTitle(title: "Location"),
                  buildTextField(locationController,"Montreal,Canada"),

                  // Destination
                  SectionTitle(title: "Destination"),
                  buildTextField(destinationController,"tokyo,Japan"),
                  const SizedBox(height: 10,),

                  // Dates
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: "Departure"),
                            const SizedBox(height: 6),
                            buildDateField("Departure", departureDate),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(title: "Return"),
                            const SizedBox(height: 6),
                            buildDateField("Return", returnDate),
                          ],
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 12),

                  // Passenger Dropdown
                  PassengersDropDownMenuFormField(),

                  const SizedBox(height: 24),

                  // Search Button
                  AppElevatedButton(
                    buttonTitle: "Search Flights",
                    primaryButton: true,
                    onPressed: () {
                      context.read<FlightBookingCubit>().search(
                        from: locationController.text,
                        to: destinationController.text,
                        departureDate: "${departureDate!.year}-${departureDate!.month}-${departureDate!.day}",
                        returnDate: "${returnDate!.year}-${returnDate!.month}-${returnDate!.day}",
                        tripType: tripType,
                        passengers: 1,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tripTypeButton(String text, IconData icon) {
    final isSelected = tripType == text;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? AppColors.primaryColor : Colors.black54,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.primaryColor : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      selected: isSelected,
      showCheckmark: false,
      selectedColor: const Color(0xFFEBF5FF),
      backgroundColor: const Color(0xFFDADBDD),
      onSelected: (_) {
        setState(() {
          tripType = text;
        });
      },
    );
  }


  Widget buildTextField(TextEditingController controller,String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateField(String label, DateTime? date) {
    return TextField(
      decoration: InputDecoration(
        labelText: "$label (${date != null ? "${date.day}/${date.month}/${date.year}" : "Select"})",
        labelStyle: const TextStyle(
          color: AppColors.grey
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TextStyles.borderRadiusMd),
        ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(TextStyles.borderRadiusMd - 2),
        borderSide: const BorderSide(
        color: AppColors.primaryColor,
        width: 2
    ),
      ),
    ),
    );
  }
}
