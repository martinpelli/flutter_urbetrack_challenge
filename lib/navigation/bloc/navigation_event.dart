part of 'navigation_bloc.dart';

class NavigationEvent {}

class GoToHomeDetailEvent extends NavigationEvent {
  final String character;

  GoToHomeDetailEvent({required this.character});
}

class PopHomeDetailEvent extends NavigationEvent {}
