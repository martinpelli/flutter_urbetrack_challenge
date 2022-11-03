import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_client.dart';
import '../../models/people/people_model.dart';

part 'home_list_event.dart';
part 'home_list_state.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(HomeListInitialState()) {
    on<NextPageEvent>((event, emit) {
      final int newPage;
      if ((state.currentPage + 1) > event.amountOfPages) {
        newPage = 1;
        event.controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      } else {
        newPage = state.currentPage + 1;
        event.controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      }
      emit(state.copyWith(currentPage: newPage));
    });

    on<PreviousPageEvent>((event, emit) {
      final int newPage;
      if ((state.currentPage - 1) <= 0) {
        newPage = event.amountOfPages;
        event.controller.animateToPage(event.amountOfPages - 1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      } else {
        newPage = state.currentPage - 1;
        event.controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      }
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

    on<GetPeopleEvent>((event, emit) async {
      final People people = await ApiClient.getPeople();
      emit(state.copyWith(people: people));
    });

    add(GetPeopleEvent());
  }
}
