part of 'home_detail_bloc.dart';

class HomeDetailEvent {}

class GetHomeworldEvent extends HomeDetailEvent {
  final String homeWorld;

  GetHomeworldEvent({required this.homeWorld});
}

class GetVehiclesEvent extends HomeDetailEvent {
  final List<String> vehicles;

  GetVehiclesEvent({required this.vehicles});
}

class GetStarshipsEvent extends HomeDetailEvent {
  final List<String> starships;

  GetStarshipsEvent({required this.starships});
}

class ResetDetailsEvent extends HomeDetailEvent {}
