import 'dart:convert';

import 'package:airline/features/home/models/airline_model.dart';
import 'package:http/http.dart' as http;
Future<http.Response> fetchData() {
  return http.get(Uri.parse('https://www.kayak.com/h/mobileapis/directory/airlines'));
}

Future<List<AirLineModel>> fetchAllData() async {
  final response = await http
      .get(Uri.parse('https://www.kayak.com/h/mobileapis/directory/airlines'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    print(jsonResponse.toString());
    return jsonResponse.map((data) =>  AirLineModel.fromJson(data)).toList();
  } else {

    throw Exception('Failed to load album');
  }
}