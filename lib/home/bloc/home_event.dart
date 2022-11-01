part of 'home_bloc.dart';

class HomeEvent {}

class NextPageEvent extends HomeEvent {
  final int amountOfPages;

  NextPageEvent({required this.amountOfPages});
}

class PreviousPageEvent extends HomeEvent {
  final int amountOfPages;

  PreviousPageEvent({required this.amountOfPages});
}

class SearchCharacterEvent extends HomeEvent {
  final String text;

  SearchCharacterEvent({required this.text});
}
