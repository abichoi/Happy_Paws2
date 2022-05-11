import 'package:firebase_auth/firebase_auth.dart';
String userId = "";
String useremail = "";

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

//Sign up
  Future<String?> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Sign in
  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      userId = user.uid;
      useremail = email;
      print(userId);
      print(useremail);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Sign out
  Future<void> signOut() async {
    await _auth.signOut();

    print('signout');
  }
}