import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/adventure_style_filter_group.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/budget_range_view.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_filter_bottom_bar.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_rating_multi_select.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_title_with_subtitle.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/filter_search_text_field.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/single_choice_chips_group.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';

class FilterViewBody extends StatefulWidget {
  const FilterViewBody({super.key});

  @override
  State<FilterViewBody> createState() => _FilterViewBodyState();
}

class _FilterViewBodyState extends State<FilterViewBody> {
  String selectedSort = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Filter'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sort By', style: TextStyles.medium16,),
            SizedBox(height: 16,),
            SingleChoiceChipsGroup(options: [
              'Price (Low to High)', 'Price (High to Low)', 'Biggest Deals (Highest Saving)', 'Most Reviewed', 'Most Popular'
            ]),
            Divider(),
            SizedBox(height: 16,),
            Text('Budget Range', style: TextStyles.medium16,),
            SizedBox(height: 16,),
            BudgetRangeView(),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Min', style: TextStyles.medium12.copyWith(color: Colors.grey[600]),),
                Text('Max', style: TextStyles.medium12.copyWith(color: Colors.grey[600]),)
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$ 0', style: TextStyles.medium12.copyWith(color: Colors.grey[600]),),
                Text('\$ 8500', style: TextStyles.medium12.copyWith(color: Colors.grey[600]),)
              ],
            ),
            SizedBox(height: 16,),
            Divider(),
            SizedBox(height: 16,),
            buildTitleWithSubtitle(text1: 'Adventure Style ', text2: 'Multi Select'),
            SizedBox(height: 16,),
            AdventureStyleFilterGroup(),
            SizedBox(height: 16,),
            Divider(),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Location', style: TextStyles.medium16,),
                SvgPicture.asset('assets/icons/map.svg', colorFilter: ColorFilter.mode(Color(0xff1A56DB), BlendMode.srcIn),),
              ],
            ),
            SizedBox(height: 16,),
            FilterSearchTextFiled(),
            SizedBox(height: 16,),
            Container( // RemovableChip
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38),
                border: Border.all(color: Color(0xffEBF5FF))
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/cancel.svg')),
                  Text('Paris',style: TextStyles.medium12,),
                  SizedBox(width: 16,)
                ],
              ),
            ),
            SizedBox(height: 16,),
            Divider(),
            SizedBox(height: 16,),
            buildTitleWithSubtitle(text1: 'Rating ', text2: 'Multi Select'),
            SizedBox(height: 16,),
            BuildRatingMultiSelect(),
            SizedBox(height: 16,),
          ],
        ),
      ),
      bottomNavigationBar: BuildFilterBottomBar(
        onClear: () {

        },
        onFound: () {
          context.pushNamed(ResultView.routeName);
        },
      ),
    );
  }
}
