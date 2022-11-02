import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitialState()) {
    on<GoToHomeDetailEvent>((event, emit) {
      emit(NavigationDetailState(navIndex: state.currentNavIndex, character: event.character));
    });

    on<PopHomeDetailEvent>((event, emit) {
      emit(NavigationInitialState());
    });
  }
}
