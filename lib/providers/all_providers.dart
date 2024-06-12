import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_tales/services/auth_service.dart';

final authProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

final userProvider = StateProvider<AsyncValue<User?>>(
  (ref) => const AsyncValue.data(null),
);
