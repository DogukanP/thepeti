import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thepeti/models/user.dart';

class AuthorizationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String activeUserId;

  User createUser(FirebaseUser user) {
    return user == null ? null : User.createFromFirebase(user);
  }

  Stream<User> get statusControl {
    return firebaseAuth.onAuthStateChanged.map(createUser);
  }

  Future<User> registerByMail(
    String email,
    String password,
  ) async {
    var entryCard = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return createUser(entryCard.user);
  }

  Future<User> loginByMail(String email, String password) async {
    var entryCard = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return createUser(entryCard.user);
  }

  Future<void> logOut() {
    return firebaseAuth.signOut();
  }

  Future<void> resetPassword(String eposta) async {
    await firebaseAuth.sendPasswordResetEmail(email: eposta);
  }

  Future<User> signInWithGoogle() async {
    GoogleSignInAccount googleAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuthCard =
        await googleAccount.authentication;
    AuthCredential passwordlessEntryDoc = GoogleAuthProvider.getCredential(
        idToken: googleAuthCard.idToken,
        accessToken: googleAuthCard.accessToken);
    AuthResult entryCard =
        await firebaseAuth.signInWithCredential(passwordlessEntryDoc);
    return createUser(entryCard.user);
  }
}
