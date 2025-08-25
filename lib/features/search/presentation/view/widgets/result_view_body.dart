import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/search/presentation/cubit/search_cubit.dart';
import 'package:safarni/features/search/presentation/view/widgets/card_result_item.dart';

class ResultViewBody extends StatefulWidget {
  const ResultViewBody({
    super.key,
    required this.query,
    required this.location,
    required this.minPrice,
    required this.maxPrice,
    required this.minRate,
    required this.sortedBy,
  });

  final String query;
  final String location;
  final String minPrice;
  final String maxPrice;
  final String minRate;
  final String sortedBy;

  @override
  State<ResultViewBody> createState() => _ResultViewBodyState();
}

class _ResultViewBodyState extends State<ResultViewBody> {
  @override
  void initState() {
    log(widget.sortedBy);
    log(widget.sortedBy.split(' ').first);
    log(widget.sortedBy);
    context.read<SearchCubit>().searchTours(
      query: widget.query,
      location: widget.location,
      maxPrice: widget.maxPrice,
      minPrice: widget.minPrice,
      minRate: widget.minRate,
      sortedBy: widget.sortedBy.split(' ').first,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actionsList: [
          SvgPicture.asset(
            'assets/icons/search-normal.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          SizedBox(width: 33),
          GestureDetector(
            onTap: () {
              context.pushNamed(FilterView.routeName, arguments: widget.query);
            },
            child: SvgPicture.asset(
              'assets/icons/filter.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 24),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          switch (state) {
            case SearchSuccess():
              final List tourList = widget.sortedBy == 'price low' ? state.toursEntity.reversed.toList() : state.toursEntity;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.query} ',
                            style: TextStyles.semiBold20,
                          ),
                          TextSpan(
                            text: '${state.toursEntity.length} Result',
                            style: TextStyles.regular15,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.toursEntity.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return CardResultItem(
                            tourModel: TourModel.fromEntity(
                              tourList[i],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            case SearchError():
              return Center(child: Text(state.message));
            case SearchLoading():
              return const Center(child: CircularProgressIndicator());
            case SearchInitial():
              return SizedBox();
          }
        },
      ),
    );
  }
}
