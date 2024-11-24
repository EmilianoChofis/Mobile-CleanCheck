import 'package:equatable/equatable.dart';
import 'package:mobile_clean_check/data/models/models.dart';

abstract class BuildingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuildingInitial extends BuildingState {}

class BuildingLoading extends BuildingState {}

class BuildingLoaded extends BuildingState {
  final List<BuildingModel> buildings;

  BuildingLoaded({required this.buildings});

  @override
  List<Object?> get props => [buildings];
}

class BuildingSuccess extends BuildingState {
  final String message;

  BuildingSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class BuildingError extends BuildingState {
  final String message;

  BuildingError({required this.message});

  @override
  List<Object?> get props => [message];
}