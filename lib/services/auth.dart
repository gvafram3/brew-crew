import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create custom user object based on FirebaseUser / UserCredential

  CustomUser? _userFromUserCredential(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map(_userFromUserCredential);
    // .map((User? user) => _userFromUserCredential(user));
  }

  // sign in anonymously

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromUserCredential(user!);
      // return _userFromUserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromUserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register new user

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(
        uid: user!.uid,
      ).updateUserData('0', 'new crew member', 100);

      return _userFromUserCredential(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
