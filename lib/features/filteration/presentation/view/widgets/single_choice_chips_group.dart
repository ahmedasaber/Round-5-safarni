import 'package:flutter/material.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_choice_chip.dart';

class SingleChoiceChipsGroup extends StatelessWidget {
  const SingleChoiceChipsGroup({super.key, required this.options, required this.onSelected, required this.selectedSort});

  final List<String> options;
  final ValueChanged<String> onSelected;
  final String selectedSort;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((option){
        return buildChoiceChip(
          label: option,
          selected: selectedSort == option,
          onSelected: (selected) {
            if (selected) {
              onSelected(option);
            }
          },
        );
      }).toList(),
    );
  }
}