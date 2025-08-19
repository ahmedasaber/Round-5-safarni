import 'package:flutter/material.dart';


class PassengersDropDownMenuFormField extends StatefulWidget {
  const PassengersDropDownMenuFormField({super.key});

  @override
  State<PassengersDropDownMenuFormField> createState() => _PassengersDropDownMenuFormFieldState();
}

class _PassengersDropDownMenuFormFieldState extends State<PassengersDropDownMenuFormField> {
  final List<int> passengers = [1, 2, 3, 4, 5, 6];
  String passenger = "1 Passenger";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: passenger,
      decoration: InputDecoration(
        labelText: "Passenger",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: List.generate(
          5,
              (i) => DropdownMenuItem(
            value: "${i + 1} Passenger${i == 0 ? '' : 's'}",
            child: Text("${i + 1} Passenger${i == 0 ? '' : 's'}"),
          )),
      onChanged: (val) {
        setState(() {
          passenger = val!;
        });
      },
    );
  }
}
