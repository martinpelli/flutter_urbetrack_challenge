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

class SearchCharacterEvent extends HomeListEvent {
  final String text;

  SearchCharacterEvent({required this.text});
}

class GetPeopleEvent extends HomeListEvent {}

class RemoveControllerEvent extends HomeListEvent {}

class RestorePageEvent extends HomeListEvent {}
