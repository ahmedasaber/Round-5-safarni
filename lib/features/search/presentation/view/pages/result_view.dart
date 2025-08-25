import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/search/domain/repo/search_repo.dart';
import 'package:safarni/features/search/presentation/cubit/search_cubit.dart';
import 'package:safarni/features/search/presentation/view/widgets/result_view_body.dart';

class ResultView extends StatelessWidget {
  const ResultView({
    super.key,
   this.query = '',
   this.location = '',
   this.minPrice = '',
   this.maxPrice = '',
   this.minRate = '',
   this.sortedBy = '',
  });

  static const routeName = '/result';
  final String query;
  final String location;
  final String minPrice;
  final String maxPrice;
  final String minRate;
  final String sortedBy;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt<SearchRepo>()),
      child: ResultViewBody(query: query, location: location, minPrice: minPrice, maxPrice: maxPrice, minRate: minRate, sortedBy: sortedBy,),
    );
  }
}
