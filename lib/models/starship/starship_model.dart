import 'package:freezed_annotation/freezed_annotation.dart';

part 'starship_model.freezed.dart';
part 'starship_model.g.dart';

@freezed
class Starship with _$Starship {
  const Starship._();

  const factory Starship({required String name}) = _Starship;

  factory Starship.fromJson(Map<String, Object?> json) => _$StarshipFromJson(json);
}
