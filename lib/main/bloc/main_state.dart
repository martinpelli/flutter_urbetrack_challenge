part of 'main_bloc.dart';

class MainState {
  final bool isEnabled;

  MainState({required this.isEnabled});

  MainState copyWith({bool? isEnabled}) => MainState(isEnabled: isEnabled ?? this.isEnabled);

  factory MainState.fromJson(Map<String, dynamic> json) => MainState(isEnabled: json['isEnabled'] ?? true);

  Map<String, dynamic> toJson() => {"isEnabled": isEnabled};
}

class MainInitialState extends MainState {
  MainInitialState() : super(isEnabled: true);
}
