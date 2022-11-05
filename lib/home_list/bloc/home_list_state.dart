part of 'home_list_bloc.dart';

class HomeListState {
  final int currentPage;
  final bool isSearching;
  final People? people;
  final bool isLoading;
  final bool isChangingPage;

  HomeListState({required this.currentPage, required this.isSearching, required this.people, required this.isLoading, required this.isChangingPage});

  HomeListState copyWith({int? currentPage, bool? isSearching, People? people, bool? isLoading, bool? isChangingPage}) => HomeListState(
      currentPage: currentPage ?? this.currentPage,
      isSearching: isSearching ?? this.isSearching,
      people: people ?? this.people,
      isLoading: isLoading ?? this.isLoading,
      isChangingPage: isChangingPage ?? this.isChangingPage);
}

class HomeListInitialState extends HomeListState {
  HomeListInitialState() : super(currentPage: 1, isSearching: false, people: null, isLoading: false, isChangingPage: false);
}

class HomeListSearchingState extends HomeListState {
  HomeListSearchingState() : super(currentPage: 1, isSearching: false, people: null, isLoading: true, isChangingPage: false);
}
