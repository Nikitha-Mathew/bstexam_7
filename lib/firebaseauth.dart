import 'package:firebase_auth/firebase_auth.dart';

class FireBaseFunctions {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String?> registerUser(
      {required String email, required String pwd}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pwd);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided istoo weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return e.message;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> loginUser(
      {required String emaill, required String pwd}) async {
    try {
      await auth.signInWithEmailAndPassword(email: emaill, password: pwd);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
