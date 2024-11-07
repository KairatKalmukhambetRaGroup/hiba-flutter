import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInWithGoogle() async {
    try {
      // Trigger the Google authentication flow
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null; // User canceled the sign-in
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Create new Cretedtial
      // final AuthCredential authCredential = GoogleAuthProvider.credential(
      //   accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,
      // );

      // Sign in to Firebase with Google credential
      // final UserCredential userCredential =
      //     await _auth.signInWithCredential(authCredential);
      // return userCredential.user;

      // return token to be sent to backend
      return googleSignInAuthentication.idToken;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }
}
