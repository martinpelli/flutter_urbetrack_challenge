part of 'navigation_bloc.dart';

class NavigationState {
  final int currentNavIndex;

  NavigationState({required this.currentNavIndex});
}

class NavigationBlocInitialState extends NavigationState {
  NavigationBlocInitialState() : super(currentNavIndex: 0);
}
