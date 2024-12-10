import 'package:equatable/equatable.dart';
import 'package:mobile_clean_check/data/models/models.dart';

abstract class ReportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportsLoaded extends ReportState {
  final List<ReportModel> reports;

  ReportsLoaded({required this.reports});

  @override
  List<Object?> get props => [reports];
}

class ReportSuccess extends ReportState {
  final String message;

  ReportSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ReportError extends ReportState {
  final String message;

  ReportError({required this.message});

  @override
  List<Object?> get props => [message];
}