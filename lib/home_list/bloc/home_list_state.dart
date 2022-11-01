part of 'home_list_bloc.dart';

class HomeListState {
  final int currentPage;
  final bool isSearching;

  HomeListState({required this.currentPage, required this.isSearching});

  HomeListState copyWith({int? currentPage, bool? isSearching}) =>
      HomeListState(currentPage: currentPage ?? this.currentPage, isSearching: isSearching ?? this.isSearching);
}

class HomeInitialState extends HomeListState {
  HomeInitialState() : super(currentPage: 1, isSearching: false);
}
