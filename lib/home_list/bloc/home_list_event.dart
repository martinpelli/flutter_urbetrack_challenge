part of 'home_list_bloc.dart';

class HomeListEvent {}

class NextPageEvent extends HomeListEvent {
  final int amountOfPages;
  final PageController controller;

  NextPageEvent({required this.amountOfPages, required this.controller});
}

class PreviousPageEvent extends HomeListEvent {
  final int amountOfPages;
  final PageController controller;

  PreviousPageEvent({required this.amountOfPages, required this.controller});
}

class SearchCharacterEvent extends HomeListEvent {
  final String text;

  SearchCharacterEvent({required this.text});
}
