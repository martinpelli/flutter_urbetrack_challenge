part of 'navigation_bloc.dart';

class NavigationState {
  final int currentNavIndex;
  final String? characterDetails;

  NavigationState({required this.currentNavIndex, required this.characterDetails});

  NavigationState copyWith({int? currentNavIndex, String? characterDetails}) =>
      NavigationState(currentNavIndex: currentNavIndex ?? this.currentNavIndex, characterDetails: characterDetails ?? this.characterDetails);
}

class NavigationInitialState extends NavigationState {
  NavigationInitialState() : super(currentNavIndex: 0, characterDetails: null);
}

class NavigationMainState extends NavigationState {
  NavigationMainState() : super(currentNavIndex: 1, characterDetails: null);
}
