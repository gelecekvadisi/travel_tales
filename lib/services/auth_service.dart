import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_tales/providers/all_providers.dart';

class AuthService {
  AuthService(this.ref);

  ProviderRef ref;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      ref.read(userProvider.notifier).state = const AsyncValue.loading();
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      var user = userCredential.user;
      if (user == null) {
        throw Exception("Oluşturulan kullanıcı bilgisi alınamadı!");
      }

      ref.read(userProvider.notifier).state = AsyncValue.data(user);

      await user.updateDisplayName(userName);
      return user;
    } catch (error) {
      ref.read(userProvider.notifier).state = AsyncValue.error(
        error,
        StackTrace.current,
      );
      rethrow;
    }
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    var credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<User?> googleSignIn() async {
    try {
      var account = await GoogleSignIn().signIn();
      if (account == null) {
        return null;
      }
      ref.read(userProvider.notifier).state = const AsyncValue.loading();

      GoogleSignInAuthentication googleAuthentication =
          await account.authentication;
      var credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      ref.read(userProvider.notifier).state =
          AsyncValue.data(userCredential.user);
      return userCredential.user;
    } catch (e) {
      ref.read(userProvider.notifier).state = AsyncValue.error(
        e,
        StackTrace.current,
      );
      return null;
    }
  }
}
