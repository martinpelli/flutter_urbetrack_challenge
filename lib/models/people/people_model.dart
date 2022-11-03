import 'package:freezed_annotation/freezed_annotation.dart';

import '../character/character_model.dart';

part 'people_model.freezed.dart';
part 'people_model.g.dart';

@freezed
class People with _$People {
  const People._();

  const factory People({required int count, required String? next, required String? previous, required List<Character> results}) = _People;

  factory People.fromJson(Map<String, Object?> json) => _$PeopleFromJson(json);
}
