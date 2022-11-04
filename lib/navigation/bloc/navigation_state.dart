part of 'navigation_bloc.dart';

class NavigationState {
  final int currentNavIndex;
  final Character? character;

  NavigationState({required this.currentNavIndex, required this.character});

  NavigationState copyWith({int? currentNavIndex, Character? character}) =>
      NavigationState(currentNavIndex: currentNavIndex ?? this.currentNavIndex, character: character ?? this.character);
}

class NavigationInitialState extends NavigationState {
  NavigationInitialState() : super(currentNavIndex: 0, character: null);
}

class NavigationMainState extends NavigationState {
  NavigationMainState() : super(currentNavIndex: 1, character: null);
}
