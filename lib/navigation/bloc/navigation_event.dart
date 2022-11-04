part of 'navigation_bloc.dart';

class NavigationEvent {}

class GoToHomeDetailEvent extends NavigationEvent {
  final int characterId;
  final Character character;

  GoToHomeDetailEvent({required this.character, required this.characterId});
}

class PopHomeDetailEvent extends NavigationEvent {}

class ChangePageEvent extends NavigationEvent {
  final int navIndex;

  ChangePageEvent({required this.navIndex});
}
