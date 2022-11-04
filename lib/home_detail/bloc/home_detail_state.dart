part of 'home_detail_bloc.dart';

class HomeDetailState {
  final Homeworld? homeworld;
  final List<Vehicle>? vehicles;
  final List<Starship>? starships;
  final String snackBarMessage;

  HomeDetailState({required this.homeworld, required this.vehicles, required this.starships, required this.snackBarMessage});

  HomeDetailState copyWith({Homeworld? homeworld, List<Vehicle>? vehicles, List<Starship>? starships, String? snackBarMessage}) => HomeDetailState(
      homeworld: homeworld ?? this.homeworld,
      vehicles: vehicles ?? this.vehicles,
      starships: starships ?? this.starships,
      snackBarMessage: snackBarMessage ?? this.snackBarMessage);
}

class HomeDetailInitialState extends HomeDetailState {
  HomeDetailInitialState() : super(homeworld: null, vehicles: null, starships: null, snackBarMessage: '');
}
