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
      await prefs.setString('token', response.data!.token);
      await prefs.setString('role', response.data!.user.role.name);

      emit(AuthAuthenticated(response.data!));
    }
  }
}