import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // امسح أي session قديمة (signOut كفاية)
      await googleSignIn.signOut();
      await auth.signOut();

      // دلوقتي المستخدم لازم يختار إيميل من جديد
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken ?? '',
        accessToken: googleAuth.accessToken ?? '',
      );

      final userCredential = await auth.signInWithCredential(credential);
      // print("Google Sign-In Success: ${userCredential.user?.email}");
      return userCredential;
    } catch (e) {
      // print("Google Sign-In Error: ${e.toString()}");
      rethrow;
    }
  }
}
