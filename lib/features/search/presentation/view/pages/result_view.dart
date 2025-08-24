import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/search/domain/repo/search_repo.dart';
import 'package:safarni/features/search/presentation/cubit/search_cubit.dart';
import 'package:safarni/features/search/presentation/view/widgets/result_view_body.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.query});

  static const routeName = '/result';
  final String query;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt<SearchRepo>()),
      child: ResultViewBody(query: query,),
    );
  }
}
