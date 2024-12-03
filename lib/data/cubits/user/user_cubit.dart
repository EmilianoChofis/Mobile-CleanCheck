import 'package:bloc/bloc.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({required this.userRepository}) : super(UserInitial());

  Future<void> getUsers() async {
    if (state is UserLoading) return;
    emit(UserLoading());
    loadUsers();
  }

  Future<void> loadUsers() async {
    final response = await userRepository.getUsers();

    if (response.error && response.statusCode != 400) {
      emit(UserError(message: response.message));
    } else {
      emit(UserLoaded(users: response.data!));
    }
  }
}