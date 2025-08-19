import 'package:flutter/material.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_choice_chip.dart';

class SingleChoiceChipsGroup extends StatefulWidget {
  const SingleChoiceChipsGroup({super.key, required this.options});

  final List<String> options;

  @override
  State<SingleChoiceChipsGroup> createState() => _SingleChoiceChipsGroupState();
}

class _SingleChoiceChipsGroupState extends State<SingleChoiceChipsGroup> {
  String selectedSort = '';
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: widget.options.map((option){
        return buildChoiceChip(
          label: option,
          selected: selectedSort == option,
          onSelected: (value) {
            selectedSort = option;
            setState(() {});
          },
        );
      }).toList(),
    );
  }
}