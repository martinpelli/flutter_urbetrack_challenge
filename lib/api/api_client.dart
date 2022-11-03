import 'package:dio/dio.dart';
import 'package:flutter_urbetrack_challenge/models/character_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://swapi.dev/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/people")
  Future<List<Character>> getAllCharacters();
}
