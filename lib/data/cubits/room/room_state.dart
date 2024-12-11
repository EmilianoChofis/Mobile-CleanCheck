import 'package:equatable/equatable.dart';
import 'package:mobile_clean_check/data/models/models.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<RoomModel> rooms;

  RoomLoaded({required this.rooms});

  @override
  List<Object?> get props => [rooms];
}

class RoomSuccess extends RoomState {
  final String message;

  RoomSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RoomClean extends RoomState {
  final List<RoomModel> rooms;

  RoomClean({required this.rooms});

  @override
  List<Object?> get props => [rooms];
}

class RoomError extends RoomState {
  final String message;

  RoomError({required this.message});

  @override
  List<Object?> get props => [message];
}