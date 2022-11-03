// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Character _$$_CharacterFromJson(Map<String, dynamic> json) => _$_Character(
      name: json['name'] as String,
      gender: json['gender'] as String,
      birth_year: json['birth_year'] as String,
      eye_color: json['eye_color'] as String,
      hair_color: json['hair_color'] as String,
      height: json['height'] as String,
      homeworld: json['homeworld'] as String,
      mass: json['mass'] as String,
      starships:
          (json['starships'] as List<dynamic>).map((e) => e as String).toList(),
      vehicles:
          (json['vehicles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_CharacterToJson(_$_Character instance) =>
    <String, dynamic>{
      'name': instance.name,
      'gender': instance.gender,
      'birth_year': instance.birth_year,
      'eye_color': instance.eye_color,
      'hair_color': instance.hair_color,
      'height': instance.height,
      'homeworld': instance.homeworld,
      'mass': instance.mass,
      'starships': instance.starships,
      'vehicles': instance.vehicles,
    };
