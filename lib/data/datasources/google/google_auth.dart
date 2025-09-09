import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // امسح أي جلسة قديمة
      await googleSignIn.signOut();
      await auth.signOut();

      // المستخدم يختار الإيميل
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("❌ User canceled Google Sign-In");
        return null;
      }

      final googleAuth = await googleUser.authentication;

      // تأكد إن فيه توكنات
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        throw FirebaseAuthException(
          code: "MISSING_GOOGLE_AUTH_TOKEN",
          message: "❌ Google Sign-In returned null tokens",
        );
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await auth.signInWithCredential(credential);
      print("✅ Google Sign-In Success: ${userCredential.user?.email}");
      return userCredential;
    } catch (e) {
      print("🔥 Google Sign-In Error: $e");
      rethrow;
    }
  }
}
