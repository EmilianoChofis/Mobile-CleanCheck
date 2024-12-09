import 'package:equatable/equatable.dart';
import 'package:mobile_clean_check/data/models/models.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<UserModel> users;

  UsersLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class UserSuccess extends UserState {
  final String message;

  UserSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object?> get props => [message];
}