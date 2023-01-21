import 'package:dio/dio.dart';
import 'package:flutter_urbetrack_challenge/models/homeworld/homeworld_model.dart';
import 'package:flutter_urbetrack_challenge/models/people/people_model.dart';
import 'package:flutter_urbetrack_challenge/models/starship/starship_model.dart';
import 'package:flutter_urbetrack_challenge/models/vehicle/vehicle_model.dart';

class ApiClient {
  static final Dio _dio = Dio();
  static const String _baseSwapiUrl = "https://swapi.dev/api";

  static Future<People> getPeople(int currentPeoplePage, {String? searchText}) async {
    final String params = searchText == null ? '$currentPeoplePage' : '$currentPeoplePage&search=$searchText';
    final String path = '/people/?page=$params';
    var response = await _dio.get(_baseSwapiUrl + path);
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

  static Future<People> getSearchedPeople(String param) async {
    final String path = '/people/?search=$param';
    var response = await _dio.get(_baseSwapiUrl + path);
    final People people = People.fromJson(response.data);
    return people;
  }
}
