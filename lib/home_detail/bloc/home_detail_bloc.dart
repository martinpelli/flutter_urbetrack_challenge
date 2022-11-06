import 'package:dio/dio.dart';
import 'package:flutter_urbetrack_challenge/api/api_client.dart';
import 'package:flutter_urbetrack_challenge/models/homeworld/homeworld_model.dart';
import 'package:flutter_urbetrack_challenge/models/starship/starship_model.dart';
import 'package:flutter_urbetrack_challenge/models/vehicle/vehicle_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'home_detail_event.dart';
part 'home_detail_state.dart';

class HomeDetailBloc extends HydratedBloc<HomeDetailEvent, HomeDetailState> {
  HomeDetailBloc() : super(HomeDetailInitialState()) {
    on<GetHomeworldEvent>((event, emit) async {
      if (state.homeworlds.isNotEmpty && state.homeworlds[event.name] != null) return;

      Homeworld homeworld = await ApiClient.getHomeWorld(event.homeWorld);

      state.homeworlds[event.name] = homeworld;

      emit(state.copyWith(homeworlds: state.homeworlds));
    });

    on<GetVehiclesEvent>((event, emit) async {
      if (state.vehicles.isNotEmpty && state.vehicles[event.name] != null) return;

      final List<Vehicle> vehicles = [];

      for (String vehicleEndPoint in event.vehicles) {
        final Vehicle vehicle = await ApiClient.getVehicles(vehicleEndPoint);
        vehicles.add(vehicle);
      }

      state.vehicles[event.name] = vehicles;

      emit(state.copyWith(vehicles: state.vehicles));
    });

    on<GetStarshipsEvent>((event, emit) async {
      if (state.starships.isNotEmpty && state.starships[event.name] != null) return;

      final List<Starship> starships = [];

      for (String starshipEndPoint in event.starships) {
        final Starship starship = await ApiClient.getStarships(starshipEndPoint);
        starships.add(starship);
      }

      state.starships[event.name] = starships;

      emit(state.copyWith(starships: state.starships));
    });

    on<ReportSightingEvent>((event, emit) async {
      emit(state.copyWith(snackBarMessage: 'Enviando reporte'));
      final Map<String, dynamic> data = {"userId": event.userId, "dateTime": DateTime.now().toString(), "character_name": event.name};
      final Response response = await ApiClient.reportSighting(data);
      if (response.statusCode == 201) {
        emit(state.copyWith(snackBarMessage: 'Reporte enviado'));
        return;
      }
      emit(state.copyWith(snackBarMessage: 'Ocurrió un error en el reporte'));
    });
  }

  @override
  HomeDetailState? fromJson(Map<String, dynamic> json) => HomeDetailState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomeDetailState state) => state.toJson();
}
