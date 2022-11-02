part of 'main_bloc.dart';

class MainState {
  final bool isEnabled;

  MainState({required this.isEnabled});

  MainState copyWith({bool? isEnabled}) => MainState(isEnabled: isEnabled ?? this.isEnabled);
}

class MainInitialState extends MainState {
  MainInitialState() : super(isEnabled: true);
}
