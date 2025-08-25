import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/adventure_style_filter_group.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/budget_range_view.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_filter_bottom_bar.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_rating_multi_select.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/build_title_with_subtitle.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/filter_search_text_field.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/history_search_item.dart';
import 'package:safarni/features/filteration/presentation/view/widgets/single_choice_chips_group.dart';
import 'package:safarni/features/search/data/datasource/search_filter_history/search_filter_history.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';

class FilterViewBody extends StatefulWidget {
  const FilterViewBody({super.key, required this.query});

  final String query;
  @override
  State<FilterViewBody> createState() => _FilterViewBodyState();
}

class _FilterViewBodyState extends State<FilterViewBody> {
  TextEditingController controller = TextEditingController();
  String selectedSort = '';
  String maxPrice = '';
  String minPrice = '';
  String location = '';
  List<String> selectedStyles = [];
  List<int> selectedRatings = [];
  RangeValues rangeValues = const RangeValues(0, 8500);
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
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
            SingleChoiceChipsGroup(
              options: [
                'Price (Low to High)', 'Price (High to Low)', 'Biggest Deals (Highest Saving)', 'Most Reviewed', 'Most Popular'
              ],
              selectedSort: selectedSort,
              onSelected:(option) {
                setState(() {
                  selectedSort = option;
                });
              },
            ),
            Divider(),
            SizedBox(height: 16,),
            Text('Budget Range', style: TextStyles.medium16,),
            SizedBox(height: 16,),
            BudgetRangeView(
              budgetRange: rangeValues,
              onRangeChanged: (values){
                rangeValues = values;
                maxPrice = values.end.toString();
                minPrice = values.start.toString();
                setState(() {});
              },
            ),
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
            AdventureStyleFilterGroup(
              selectedStyles: selectedStyles,
            ),
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
            FilterSearchTextFiled(
              controller: controller,
              onChange: (value){
                location = controller.text.trim();
              },
            ),
            SizedBox(height: 16,),
            ValueListenableBuilder(
              valueListenable: getIt<SearchFilterHistoryDataSource>().listenable(),
              builder: (context, Box<String> box, _){
                final history = box.values.toList();
                return  Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(history.length, (i){
                    return HistoryFilterSearchItem(
                      title: history[i], onClear: (){
                        getIt<SearchFilterHistoryDataSource>().deleteItem(history[i]);
                      },
                    );
                  })
                );
              }
            ),
            SizedBox(height: 16,),
            Divider(),
            SizedBox(height: 16,),
            buildTitleWithSubtitle(text1: 'Rating ', text2: 'Multi Select'),
            SizedBox(height: 16,),
            BuildRatingMultiSelect(
              selectedRatings: selectedRatings,
            ),
            SizedBox(height: 16,),
          ],
        ),
      ),
      bottomNavigationBar: BuildFilterBottomBar(
        onClear: () {
          selectedSort = '';
          maxPrice = '';
          minPrice = '';
          location = '';
          controller.text = '';
          selectedStyles = [];
          selectedRatings = [];
          rangeValues = const RangeValues(0, 8500);
          setState(() {});
        },
        onFound: () {
          if(controller.text.trim().isNotEmpty){
            getIt<SearchFilterHistoryDataSource>().saveSearch(controller.text.trim());
          }
          switch(selectedSort){
            case 'Price (Low to High)':
              selectedSort = 'price high';
            case 'Price (High to Low)':
                selectedSort = 'price low';
            case 'Biggest Deals (Highest Saving)':
                selectedSort = 'biggest';
            case 'Most Reviewed':
                selectedSort = 'MostReviewed';
            case 'Most Popular':
                selectedSort = 'MostPopular';
          }
          context.pushNamed(
            ResultView.routeName,
            arguments: ResultView(
              query: widget.query,
              sortedBy: selectedSort.toLowerCase(),
              maxPrice: maxPrice ,
              minPrice: minPrice,
              location: location,
              minRate: selectedRatings.isNotEmpty ? selectedRatings[0].toString() : '',
            )
          );
        },
      ),
    );
  }
}