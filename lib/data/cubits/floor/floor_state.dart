import 'package:equatable/equatable.dart';
import 'package:mobile_clean_check/data/models/models.dart';

abstract class FloorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FloorInitial extends FloorState {}

class FloorLoading extends FloorState {}

class FloorLoaded extends FloorState {
  final List<FloorModel> floors;

  FloorLoaded({required this.floors});

  @override
  List<Object?> get props => [floors];
}

class FloorSuccess extends FloorState {
  final String message;

  FloorSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class FloorError extends FloorState {
  final String message;

  FloorError({required this.message});

  @override
  List<Object?> get props => [message];
}