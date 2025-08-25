import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/features/home/presentation/cubit/available%20tours/available_tours_cubit.dart';
import 'package:safarni/features/home/presentation/cubit/categories/categories_cubit.dart';
import 'package:safarni/features/home/presentation/cubit/recommendation/recommendations_cubit.dart';
import 'package:safarni/features/home/presentation/views/widgets/list_of_available_tours.dart';
import 'package:safarni/features/home/presentation/views/widgets/list_of_categories.dart';
import 'package:safarni/features/search/presentation/view/pages/search_view.dart';
import 'package:safarni/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_filter_button.dart';
import 'package:safarni/features/home/presentation/views/widgets/list_of_recommendations.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_search_text_field.dart';

// ignore: must_be_immutable
class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {

  @override
  void initState() {
    context.read<CategoriesCubit>().loadCategories();
    context.read<RecommendationsCubit>().loadRecommendations();
    context.read<AvailableToursCubit>().loadAvailableTours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, categoriesState) {
        return BlocBuilder<RecommendationsCubit, RecommendationsState>(
          builder: (context, recommendationsState) {
            return BlocBuilder<AvailableToursCubit, AvailableToursState>(
              builder: (context, availableToursState) {
                if(categoriesState is CategoriesLoading ||
                    recommendationsState is RecommendationsLoading ||
                    availableToursState is AvailableToursLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                return Scaffold(
                  appBar: HomeAppBar(),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomSearchTextField(
                                  onTap: () {
                                    context.pushNamed(SearchView.routeName);
                                  },
                                  readOnly: true,
                                )),
                              SizedBox(width: 13),
                              CustomFilterBt(
                                onTap: () {
                                  context.pushNamed(FilterView.routeName, arguments: ' ');
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 24,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 221,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/travel-image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Categories',
                            style: TextStyles.medium17,
                          ),
                        ),
                        SizedBox(height: 16,),
                        ListOfCategories(categories:
                        categoriesState is CategoriesSuccess
                          ? categoriesState.categories
                          : [],
                        ),
                        SizedBox(height: 16,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Recommendation', style: TextStyles.medium17),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View all',
                                  style: TextStyles.medium13.copyWith(
                                    color: Color(0xff1E429F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ListOfRecommendations(
                            recommendedList: recommendationsState is RecommendationsSuccess
                            ? recommendationsState.recommendations
                            : [],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Available Tours',
                                  style: TextStyles.medium17),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View all',
                                  style: TextStyles.medium13.copyWith(
                                    color: Color(0xff1E429F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListOfAvailableTours(
                          toursList: availableToursState is AvailableToursSuccess
                          ? availableToursState.availableTours
                          : [],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
