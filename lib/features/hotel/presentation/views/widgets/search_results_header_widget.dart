import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class SearchResultsHeaderWidget extends StatelessWidget {
  final int resultsCount;
  final VoidCallback onClearSearch;

  const SearchResultsHeaderWidget({
    super.key,
    required this.resultsCount,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Search Results ($resultsCount)',
          style: TextStyles.font17LightBlackNormal,
        ),
        TextButton(
          onPressed: onClearSearch,
          child: Text('Clear', style: TextStyles.font15DarkBlueNormal),
        ),
      ],
    );
  }
}
