import 'package:google_sign_in/google_sign_in.dart';

/// A provider class for handling Google Sign-In authentication.
///
/// `GoogleSignInProvider` allows users to sign in with their Google account,
/// returning an ID token that can be sent to a backend for further processing.
///
/// Example usage:
/// ```dart
/// GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();
/// String? token = await googleSignInProvider.signInWithGoogle();
/// if (token != null) {
///   // Proceed with sending token to the backend
/// }
/// ```

class GoogleSignInProvider {
  // Instance of GoogleSignIn for handling Google authentication flow.
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Signs in the user with Google and returns an ID token if successful.
  ///
  /// This method initiates the Google Sign-In flow, allowing the user to log in
  /// using their Google account. If the sign-in is successful, it retrieves the
  /// authentication details and returns the `idToken`, which can be sent to a backend
  /// server for validation. If the user cancels the sign-in, it returns `null`.
  ///
  /// Note:
  /// - Uncommented code blocks allow Firebase authentication with Google credentials.
  /// - Currently, only the `idToken` is returned, not a signed-in Firebase user.
  ///
  /// Returns:
  /// - `String?`: The Google ID token, or `null` if sign-in was unsuccessful or canceled.
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
