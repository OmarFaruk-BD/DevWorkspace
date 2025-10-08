import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workspace/features/auth/model/user_model.dart';

class AdminAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        return left('No user found for that email.');
      } else {
        final UserModel user = UserModel(
          id: result.user?.uid,
          name: result.user!.displayName,
          email: result.user!.email,
          phone: result.user!.phoneNumber,
        );
        return right(user);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return left('No user found for that email.');
        case 'wrong-password':
          return left('Wrong password provided.');
        case 'invalid-email':
          return left('The email address is not valid.');
        default:
          return left('Login failed: ${e.message}');
      }
    } catch (e) {
      return left('Something went wrong.');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
