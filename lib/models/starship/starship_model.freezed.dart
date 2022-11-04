// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'starship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Starship _$StarshipFromJson(Map<String, dynamic> json) {
  return _Starship.fromJson(json);
}

/// @nodoc
mixin _$Starship {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StarshipCopyWith<Starship> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarshipCopyWith<$Res> {
  factory $StarshipCopyWith(Starship value, $Res Function(Starship) then) =
      _$StarshipCopyWithImpl<$Res, Starship>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$StarshipCopyWithImpl<$Res, $Val extends Starship>
    implements $StarshipCopyWith<$Res> {
  _$StarshipCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StarshipCopyWith<$Res> implements $StarshipCopyWith<$Res> {
  factory _$$_StarshipCopyWith(
          _$_Starship value, $Res Function(_$_Starship) then) =
      __$$_StarshipCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_StarshipCopyWithImpl<$Res>
    extends _$StarshipCopyWithImpl<$Res, _$_Starship>
    implements _$$_StarshipCopyWith<$Res> {
  __$$_StarshipCopyWithImpl(
      _$_Starship _value, $Res Function(_$_Starship) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_Starship(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Starship extends _Starship {
  const _$_Starship({required this.name}) : super._();

  factory _$_Starship.fromJson(Map<String, dynamic> json) =>
      _$$_StarshipFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'Starship(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Starship &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StarshipCopyWith<_$_Starship> get copyWith =>
      __$$_StarshipCopyWithImpl<_$_Starship>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StarshipToJson(
      this,
    );
  }
}

abstract class _Starship extends Starship {
  const factory _Starship({required final String name}) = _$_Starship;
  const _Starship._() : super._();

  factory _Starship.fromJson(Map<String, dynamic> json) = _$_Starship.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_StarshipCopyWith<_$_Starship> get copyWith =>
      throw _privateConstructorUsedError;
}
