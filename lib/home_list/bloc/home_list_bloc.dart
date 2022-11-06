import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../api/api_client.dart';
import '../../models/people/people_model.dart';

part 'home_list_event.dart';
part 'home_list_state.dart';

class HomeListBloc extends HydratedBloc<HomeListEvent, HomeListState> {
  int _lastPeoplePage = 0;
  bool restorePage = false;
  double? previousHeight;

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
      emit(HomeListSearchingState(text: searchController.text));
      if (searchController.text.isEmpty) {
        emit(state.copyWith(isSearching: false, currentPeoplePage: 0));
        add(GetPeopleEvent());
        return;
      }
      final People filteredPeople = await ApiClient.getSearchedPeople(searchController.text);
      _lastPeoplePage = filteredPeople.count == 0 ? 0 : (filteredPeople.count / filteredPeople.results.length).ceil();
      emit(state.copyWith(people: filteredPeople, isSearching: true, isLoading: false, currentPeoplePage: 1));
    });

    on<GetPeopleEvent>((event, emit) async {
      if (state.people != null && (state.people!.results.length == state.people!.count || state.currentPeoplePage >= _lastPeoplePage)) return;

      emit(state.copyWith(isLoading: true, currentPeoplePage: state.currentPeoplePage + 1));

      print(state.currentPeoplePage);

      final People people = await ApiClient.getPeople('${state.currentPeoplePage}');

      if (state.currentPeoplePage > 1) {
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

  @override
  HomeListState? fromJson(Map<String, dynamic> json) {
    final HomeListState localState = HomeListState.fromJson(json);
    if (localState.people != null) _lastPeoplePage = (localState.people!.count / localState.people!.results.length).ceil();
    if (localState.searchText.isNotEmpty) searchController.text = localState.searchText;
    return localState;
  }

  @override
  Map<String, dynamic>? toJson(HomeListState state) => state.toJson();
}
