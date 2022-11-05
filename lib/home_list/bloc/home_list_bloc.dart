import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api_client.dart';
import '../../models/people/people_model.dart';

part 'home_list_event.dart';
part 'home_list_state.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  int _peoplePage = 0;
  int _lastPeoplePage = 0;
  bool restorePage = false;

  PageController pageController = PageController(initialPage: 0);
  final TextEditingController searchController = TextEditingController();

  HomeListBloc() : super(HomeListInitialState()) {
    on<NextPageEvent>((event, emit) async {
      emit(state.copyWith(isChangingPage: true));
      final int newPage;
      if ((state.currentPage + 1) > event.amountOfPages) {
        newPage = 1;
        await pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
      } else {
        newPage = state.currentPage + 1;
        await pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
      emit(state.copyWith(currentPage: newPage, isChangingPage: false));
    });

    on<PreviousPageEvent>((event, emit) async {
      emit(state.copyWith(isChangingPage: true));
      final int newPage;
      if ((state.currentPage - 1) <= 0) {
        newPage = event.amountOfPages;
        await pageController.animateToPage(event.amountOfPages - 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
      } else {
        newPage = state.currentPage - 1;
        await pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
      emit(state.copyWith(currentPage: newPage, isChangingPage: false));
    });

    on<SearchCharacterEvent>((event, emit) async {
      emit(HomeListSearchingState());
      if (searchController.text.isEmpty) {
        emit(state.copyWith(isSearching: false));
        _peoplePage = 0;
        add(GetPeopleEvent());
        return;
      }
      final People filteredPeople = await ApiClient.getSearchedPeople(searchController.text);
      _peoplePage = 1;
      _lastPeoplePage = filteredPeople.count == 0 ? 0 : (filteredPeople.count / filteredPeople.results.length).ceil();
      emit(state.copyWith(people: filteredPeople, isSearching: true, isLoading: false));
    });

    on<GetPeopleEvent>((event, emit) async {
      if (state.people != null && (state.people!.results.length == state.people!.count || _peoplePage >= _lastPeoplePage)) return;

      emit(state.copyWith(isLoading: true));

      _peoplePage += 1;

      final People people = await ApiClient.getPeople('$_peoplePage');

      if (_peoplePage > 1) {
        People newPeople = state.people!.copyWith(results: [...state.people!.results, ...people.results]);
        emit(state.copyWith(people: newPeople, isLoading: false));
      } else {
        _lastPeoplePage = (people.count / people.results.length).ceil();
        emit(state.copyWith(people: people, isLoading: false));
      }
    });

    on<RemoveControllerEvent>(((event, emit) {
      if (pageController.hasClients) pageController.dispose();
    }));

    on<RestorePageEvent>((event, emit) async {
      pageController = PageController(initialPage: state.currentPage - 1);
    });

    add(GetPeopleEvent());
  }
}
