import 'package:dio/dio.dart';
import 'package:flutter_urbetrack_challenge/models/homeworld/homeworld_model.dart';
import 'package:flutter_urbetrack_challenge/models/people/people_model.dart';
import 'package:flutter_urbetrack_challenge/models/starship/starship_model.dart';
import 'package:flutter_urbetrack_challenge/models/vehicle/vehicle_model.dart';

class ApiClient {
  static final Dio _dio = Dio();

  static Future<People> getPeople(String param) async {
    const String baseUrl = "https://swapi.dev/api";
    final String path = '/people/?page=$param';
    var response = await _dio.get(baseUrl + path);
    final People people = People.fromJson(response.data);
    return people;
  }

  static Future<Homeworld> getHomeWorld(String url) async {
    var response = await _dio.get(url);
    final Homeworld homeworld = Homeworld.fromJson(response.data);
    return homeworld;
  }

  static Future<Vehicle> getVehicles(String url) async {
    var response = await _dio.get(url);
    final Vehicle vehicles = Vehicle.fromJson(response.data);
    return vehicles;
  }

  static Future<Starship> getStarships(String url) async {
    var response = await _dio.get(url);
    final Starship starships = Starship.fromJson(response.data);
    return starships;
  }

  static Future<Response> reportSighting(Map<String, dynamic> data) async {
    const String baseUrl = "https://jsonplaceholder.typicode.com/posts";
    return await _dio.post(baseUrl, data: data);
  }
}
