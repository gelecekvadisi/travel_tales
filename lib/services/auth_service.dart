import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_tales/providers/all_providers.dart';

class AuthService {
  AuthService(this.ref);

  ProviderRef ref;

  Future<User> registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      ref.read(userProvider.notifier).state = AsyncValue.loading();
      var firebaseAuth = FirebaseAuth.instance;
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
}
