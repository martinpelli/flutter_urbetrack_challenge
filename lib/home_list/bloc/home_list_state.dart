part of 'home_list_bloc.dart';

class HomeListState {
  final int currentPage;
  final bool isSearching;
  final People? people;

  HomeListState({
    required this.currentPage,
    required this.isSearching,
    required this.people,
  });

  HomeListState copyWith({int? currentPage, bool? isSearching, People? people}) =>
      HomeListState(currentPage: currentPage ?? this.currentPage, isSearching: isSearching ?? this.isSearching, people: people ?? this.people);
}

class HomeListInitialState extends HomeListState {
  HomeListInitialState() : super(currentPage: 1, isSearching: false, people: null);
}
