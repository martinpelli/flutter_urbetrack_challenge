import 'package:freezed_annotation/freezed_annotation.dart';

part 'character_model.freezed.dart';
part 'character_model.g.dart';

@freezed
class Character with _$Character {
  const Character._();

  const factory Character(
      {required String name,
      required String gender,
      required String birth_year,
      required String eye_color,
      required String hair_color,
      required String height,
      required String homeworld,
      required String mass,
      required List<String> starships,
      required List<String> vehicles}) = _Character;

  factory Character.fromJson(Map<String, Object?> json) => _$CharacterFromJson(json);
}
