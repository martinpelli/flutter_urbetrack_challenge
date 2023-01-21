import 'package:flutter_urbetrack_challenge/models/character/character_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends HydratedBloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitialState()) {
    on<GoToHomeDetailEvent>(
        (event, emit) => emit(state.copyWith(currentNavIndex: state.currentNavIndex, characterId: event.characterId, character: event.character)));

    on<PopHomeDetailEvent>((event, emit) => emit(NavigationInitialState()));

    on<ChangePageEvent>(((event, emit) => emit(state.copyWith(currentNavIndex: event.navIndex))));
  }

  @override
  NavigationState? fromJson(Map<String, dynamic> json) => NavigationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NavigationState state) => state.toJson();
}
