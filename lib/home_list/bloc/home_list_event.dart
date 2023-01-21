part of 'home_list_bloc.dart';

class HomeListEvent {}

class NextPageEvent extends HomeListEvent {
  final int amountOfPages;

  NextPageEvent({required this.amountOfPages});
}

class PreviousPageEvent extends HomeListEvent {
  final int amountOfPages;

  PreviousPageEvent({required this.amountOfPages});
}

class SearchCharacterEvent extends HomeListEvent {}

class GetPeopleEvent extends HomeListEvent {}
