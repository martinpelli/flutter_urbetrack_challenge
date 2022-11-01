import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_list_event.dart';
part 'home_list_state.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(HomeInitialState()) {
    on<NextPageEvent>((event, emit) {
      final int newPage = (state.currentPage + 1) > event.amountOfPages ? 1 : state.currentPage + 1;
      emit(state.copyWith(currentPage: newPage));
    });

    on<PreviousPageEvent>((event, emit) {
      final int newPage = (state.currentPage - 1) <= 0 ? event.amountOfPages : state.currentPage - 1;
      emit(state.copyWith(currentPage: newPage));
    });

    on<SearchCharacterEvent>((event, emit) {
      if (event.text.isEmpty) {
        emit(state.copyWith(isSearching: false));
        return;
      }
      print("searching");
      emit(state.copyWith(isSearching: true));
    });
  }
}
