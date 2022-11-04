import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_model.freezed.dart';
part 'vehicle_model.g.dart';

@freezed
class Vehicle with _$Vehicle {
  const Vehicle._();

  const factory Vehicle({required String name}) = _Vehicle;

  factory Vehicle.fromJson(Map<String, Object?> json) => _$VehicleFromJson(json);
}
