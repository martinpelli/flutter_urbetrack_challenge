part of 'home_bloc.dart';

class HomeState {
  final int currentPage;
  final bool isSearching;

  HomeState({required this.currentPage, required this.isSearching});

  HomeState copyWith({int? currentPage, bool? isSearching}) =>
      HomeState(currentPage: currentPage ?? this.currentPage, isSearching: isSearching ?? this.isSearching);
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(currentPage: 1, isSearching: false);
}
