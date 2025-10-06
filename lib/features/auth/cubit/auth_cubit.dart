import 'package:bloc/bloc.dart';
import 'package:workspace/features/auth/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void updateUser(UserModel? user) {
    emit(state.copyWith(user: user));
  }

  void signOut() {
    emit(AuthInitial());
  }
}
