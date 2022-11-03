import 'package:dio/dio.dart';
import 'package:flutter_urbetrack_challenge/models/people/people_model.dart';

class ApiClient {
  static final Dio _dio = Dio();
  static const String _baseUrl = "https://swapi.dev/api";

  static Future<People> getPeople() async {
    const String path = "/people";
    var response = await _dio.get(_baseUrl + path);
    final People people = People.fromJson(response.data);
    return people;
  }
}
