import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  Future<UserCredential> getUserCredintial(
      {required String mail, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password);

    return userCredential;
  }
}
