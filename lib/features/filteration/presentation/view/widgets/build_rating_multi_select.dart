import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_choice_chip.dart';

class BuildRatingMultiSelect extends StatefulWidget {
  const BuildRatingMultiSelect({super.key, required this.selectedRatings});
  final List selectedRatings;

  @override
  State<BuildRatingMultiSelect> createState() => _BuildRatingMultiSelectState();
}

class _BuildRatingMultiSelectState extends State<BuildRatingMultiSelect> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: List.generate(5, (i){
        final rating = i+1;
        bool isSelected = widget.selectedRatings.contains(rating);
        return buildChoiceChip(
            icon: SvgPicture.asset('assets/icons/star.svg', width: 24, height: 24,
              colorFilter: isSelected? ColorFilter.mode(Color(0xff1E429F),BlendMode.srcIn):null,
            ),
            label: rating.toString(),
            selected: isSelected,
            onSelected: (selected){
              selected?  widget.selectedRatings.add(rating) : widget.selectedRatings.remove(rating);
              setState(() {});
              widget.selectedRatings.sort();
            }
        );
      }),
    );
  }
}