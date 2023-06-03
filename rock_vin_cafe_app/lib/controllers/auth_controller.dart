import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> emailAndPasswordSignIn(String email, String password);
  Future<User?> createAccountWithEmailAndPassword(
      String email, String password);
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<User?> signInwithPhone();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> createAccountWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    // print();
    return userCredential.user;
  }

  @override
  Future<User?> emailAndPasswordSignIn(String email, String password) {
    // TODO: implement emailAndPasswordSignIn
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<User?> signInwithPhone() {
    // TODO: implement signInwithPhone
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
