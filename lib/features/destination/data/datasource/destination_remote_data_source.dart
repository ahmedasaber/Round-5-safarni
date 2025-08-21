import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/destination_model.dart';

abstract class DestinationRemoteDataSource {
  Future<DestinationModel> getDestinationDetails(String id);
}

class DestinationRemoteDataSourceImpl implements DestinationRemoteDataSource {
  final http.Client client;

  DestinationRemoteDataSourceImpl(this.client);

  @override
  Future<DestinationModel> getDestinationDetails(String id) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/destinations/$id'),
    );

    if (response.statusCode == 200) {
      return DestinationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load destination details");
    }
  }
}
