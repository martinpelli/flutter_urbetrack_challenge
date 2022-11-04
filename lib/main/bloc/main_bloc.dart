import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends HydratedBloc<MainEvent, MainState> {
  MainBloc() : super(MainInitialState()) {
    on<ChangeConnectionEvent>((event, emit) => emit(state.copyWith(isEnabled: event.value)));
  }

  @override
  MainState? fromJson(Map<String, dynamic> json) => MainState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(MainState state) => state.toJson();
}
