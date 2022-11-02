part of 'main_bloc.dart';

class MainEvent {}

class ChangeConnectionEvent extends MainEvent {
  final bool value;

  ChangeConnectionEvent({required this.value});
}
