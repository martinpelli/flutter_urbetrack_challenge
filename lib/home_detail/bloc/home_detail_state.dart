part of 'home_detail_bloc.dart';

class HomeDetailState {
  final Map<String, Homeworld?> homeworlds;
  final Map<String, List<Vehicle>?> vehicles;
  final Map<String, List<Starship>?> starships;
  final String snackBarMessage;

  HomeDetailState({required this.homeworlds, required this.vehicles, required this.starships, required this.snackBarMessage});

  HomeDetailState copyWith(
          {Map<String, Homeworld?>? homeworlds,
          Map<String, List<Vehicle>?>? vehicles,
          Map<String, List<Starship>?>? starships,
          String? snackBarMessage}) =>
      HomeDetailState(
          homeworlds: homeworlds ?? this.homeworlds,
          vehicles: vehicles ?? this.vehicles,
          starships: starships ?? this.starships,
          snackBarMessage: snackBarMessage ?? this.snackBarMessage);

  factory HomeDetailState.fromJson(Map<String, dynamic> json) => HomeDetailState(
      homeworlds: Map.from(json["homeworlds"]).map((key, homeworld) => MapEntry(key, homeworld != null ? Homeworld.fromJson(homeworld) : null)),
      vehicles: Map.from(json["vehicles"])
          .map((key, vehicles) => MapEntry(key, vehicles != null ? List.from(vehicles).map((v) => Vehicle.fromJson(v)).toList() : null)),
      starships: Map.from(json["starships"])
          .map((key, starships) => MapEntry(key, starships != null ? List.from(starships).map((s) => Starship.fromJson(s)).toList() : null)),
      snackBarMessage: json['snackBarMessage'] ?? '');

  Map<String, dynamic> toJson() => {"homeworlds": homeworlds, "vehicles": vehicles, "starships": starships, "snackBarMessage": snackBarMessage};
}

class HomeDetailInitialState extends HomeDetailState {
  HomeDetailInitialState() : super(homeworlds: {}, vehicles: {}, starships: {}, snackBarMessage: '');
}
