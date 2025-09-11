import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // 🧹 امسح أي جلسة قديمة
      await googleSignIn.signOut();
      await auth.signOut();

      // 👤 حاول تسجيل الدخول بصمت أولًا
      GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
      googleUser ??= await googleSignIn
          .signIn(); // لو مفيش جلسة صامتة افتح نافذة تسجيل

      if (googleUser == null) {
        // print("❌ User canceled Google Sign-In");
        return null;
      }

      final googleAuth = await googleUser.authentication;

      // ✅ تأكد من وجود توكنات
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        throw FirebaseAuthException(
          code: "MISSING_GOOGLE_AUTH_TOKEN",
          message: "❌ Google Sign-In returned null tokens",
        );
      }

      // 🔑 بناء الـ credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // 🚀 تسجيل الدخول بالفirebase
      UserCredential userCredential;
      try {
        userCredential = await auth.signInWithCredential(credential);
      } catch (e) {
        // ⚠️ لو التوكن انتهت صلاحيته حاول تسجيل الدخول مرة تانية
        if (e is FirebaseAuthException && e.code == 'invalid-credential') {
          // print("⚠️ Token expired. Retrying...");
          final newGoogleUser = await googleSignIn.signIn();
          if (newGoogleUser == null) return null;

          final newAuth = await newGoogleUser.authentication;
          final newCredential = GoogleAuthProvider.credential(
            idToken: newAuth.idToken,
            accessToken: newAuth.accessToken,
          );
          userCredential = await auth.signInWithCredential(newCredential);
        } else {
          rethrow;
        }
      }

      final user = userCredential.user;
      if (user == null) {
        throw FirebaseAuthException(
          code: "USER_NOT_FOUND",
          message: "❌ No user data found after Google Sign-In",
        );
      }

      // 🔄 force refresh token
      // String? freshToken = await user.getIdToken(true);

      // print("✅ Google Sign-In Success: ${user.email}");
      // print("📌 Name: ${user.displayName}");
      // print("📌 Photo: ${user.photoURL}");
      // print("🔑 Fresh Token: $freshToken");

      return userCredential;
    } catch (e) {
      // print("🔥 Google Sign-In Error: $e");
      rethrow;
    }
  }
}
