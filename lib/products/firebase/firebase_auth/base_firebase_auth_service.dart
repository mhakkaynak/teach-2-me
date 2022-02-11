
import '../../models/user_model.dart';

abstract class IFirebaseAuthService {
  bool isItRegistered();

  Future<String> register(UserModel model);

  Future<String> signInWithEmail(UserModel model);

  Future<String> signInWithGoogle();

  Future<void> signOut();
}
