part of 'navigation_bloc.dart';

class NavigationState {
  final int currentNavIndex;
  final int? characterId;
  final Character? character;

  NavigationState({required this.currentNavIndex, required this.characterId, required this.character});

  NavigationState copyWith({int? currentNavIndex, int? characterId, Character? character}) => NavigationState(
      currentNavIndex: currentNavIndex ?? this.currentNavIndex, characterId: characterId ?? this.characterId, character: character ?? this.character);

  factory NavigationState.fromJson(Map<String, dynamic> json) => NavigationState(
      characterId: json['characterId'],
      character: json['character'] != null ? Character.fromJson(json['character']) : null,
      currentNavIndex: json['currentNavIndex'] ?? 0);

  Map<String, dynamic> toJson() => {"characterId": characterId, "character": character, "currentNavIndex": currentNavIndex};
}

class NavigationInitialState extends NavigationState {
  NavigationInitialState() : super(currentNavIndex: 0, character: null, characterId: null);
}

class NavigationMainState extends NavigationState {
  NavigationMainState() : super(currentNavIndex: 1, character: null, characterId: null);
}
