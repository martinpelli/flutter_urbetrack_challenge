import 'package:freezed_annotation/freezed_annotation.dart';

part 'homeworld_model.freezed.dart';
part 'homeworld_model.g.dart';

@freezed
class Homeworld with _$Homeworld {
  const Homeworld._();

  const factory Homeworld({required String name}) = _Homeworld;

  factory Homeworld.fromJson(Map<String, Object?> json) => _$HomeworldFromJson(json);
}
