import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/models/models.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(AuthModel auth) async {
    emit(AuthLoading());

    final response = await authRepository.login(auth);

    if (response.error) {
      emit(AuthError(response.message));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String name = response.data!.user.name;

      await prefs.setString('user', name);
      await prefs.setString('userId', response.data!.user.id!);
      await prefs.setString('token', response.data!.token);
      await prefs.setString('role', response.data!.user.role!.name);
      await prefs.setString('user_json', jsonEncode(response.data!.user));

      emit(AuthAuthenticated(response.data!));
    }
  }

  Future<void> checkAuthentication() async {
    emit(AuthLoading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final role = prefs.getString('role');

    if (token != null && role != null) {
      final user = jsonDecode(prefs.getString('user_json')!);
      final auth = AuthResponse(token: token, user: UserModel.fromJson(user));
      emit(AuthAuthenticated(auth));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(AuthInitial());
  }

}
