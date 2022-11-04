part of 'navigation_bloc.dart';

class NavigationEvent {}

class GoToHomeDetailEvent extends NavigationEvent {
  final Character character;

  GoToHomeDetailEvent({required this.character});
}

class PopHomeDetailEvent extends NavigationEvent {}

class ChangePageEvent extends NavigationEvent {
  final int navIndex;

  ChangePageEvent({required this.navIndex});
}
