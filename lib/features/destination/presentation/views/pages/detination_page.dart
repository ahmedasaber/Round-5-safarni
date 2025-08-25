import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../data/datasource/destination_remote_data_source.dart';
import '../../../data/models/destination_model.dart';
import '../widgets/best_time_to_visit.dart';
import '../widgets/botton_bar.dart';
import '../widgets/build_top_section.dart';
import '../widgets/gallery.dart';
import '../widgets/reviews.dart';
import '../widgets/top_activates.dart';
import '../widgets/trip_details.dart';

class DestinationView extends StatelessWidget {
  final String destinationId;

  const DestinationView({super.key,this.destinationId = "1"});
  static const routeName = '/destination';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _loadDestinationDetails(destinationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final destination = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  BuildTopSection(),
                  TripDetails(),
                  TopActivates(),
                  BestTimeToVisit(),
                  Gallery(),
                  Reviews(),
                  const SizedBox(height: 100),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<DestinationModel> _loadDestinationDetails(String id) async {
    final dataSource = DestinationRemoteDataSourceImpl(Dio());
    return await dataSource.getDestinationDetails(id);
  }
}
