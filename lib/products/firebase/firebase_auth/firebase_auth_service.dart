import '../../models/user_model.dart';
import '../firestore/firestore_service.dart';
import 'base_firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements IFirebaseAuthService {
  FirebaseAuthService._init() {
    _auth = FirebaseAuth.instance;
  }

  static FirebaseAuthService? _instance;

  late final FirebaseAuth _auth;

  String? get uid => _auth.currentUser?.uid;

  @override
  bool isItRegistered() {
    return _auth.currentUser != null;
  }

  @override
  Future<String> register(UserModel model) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: model.email.toString(), password: model.password.toString());
      await _insertUserInFirestore(UserModel(
        uid: user.user!.uid,
        email: model.email,
        name: model.name,
        subjects: model.subjects,
      ));
      return 'Welcome ${model.name}';
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  @override
  Future<String> signInWithEmail(UserModel model) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: model.email.toString(), password: model.password.toString());
      return 'Welcome ${user.user?.displayName}';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    try {
      var googleSignIn = GoogleSignIn();
      var googleSignInAccount = await googleSignIn.signIn();
      var googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      var user = await _auth.signInWithCredential(credential);
      _insertUserInFirestore(UserModel(
        uid: user.user?.uid,
        email: user.user?.email,
        name: user.user?.displayName,
      ));
      return 'Welcome ${user.user?.displayName}';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Future<void> signOut() async {
    //LocaleManager.instance?.clearData(); //
    // TODO: belki
    await _auth.signOut();
  }

  static FirebaseAuthService? get instance {
    _instance ??= FirebaseAuthService._init();
    return _instance;
  }

  Future<void> _insertUserInFirestore(UserModel model) async {
     await FirestoreService.instance?.insertUser(model); 
  }
}
