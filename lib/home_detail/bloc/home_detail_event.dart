part of 'home_detail_bloc.dart';

class HomeDetailEvent {}

class GetHomeworldEvent extends HomeDetailEvent {
  final String name;
  final String homeWorld;

  GetHomeworldEvent({required this.homeWorld, required this.name});
}

class GetVehiclesEvent extends HomeDetailEvent {
  final String name;
  final List<String> vehicles;

  GetVehiclesEvent({required this.vehicles, required this.name});
}

class GetStarshipsEvent extends HomeDetailEvent {
  final String name;
  final List<String> starships;

  GetStarshipsEvent({required this.starships, required this.name});
}

class ReportSightingEvent extends HomeDetailEvent {
  final int userId;
  final String name;

  ReportSightingEvent({required this.userId, required this.name});
}
