part of 'navigation_bloc.dart';

class NavigationState {
  final int currentNavIndex;
  final String? characterDetails;

  NavigationState({required this.currentNavIndex, required this.characterDetails});
}

class NavigationInitialState extends NavigationState {
  NavigationInitialState() : super(currentNavIndex: 0, characterDetails: null);
}

class NavigationDetailState extends NavigationState {
  final int navIndex;
  final String character;

  NavigationDetailState({required this.navIndex, required this.character}) : super(currentNavIndex: navIndex, characterDetails: character);
}
