import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth.dart';

// import '../models/auth.dart';

// final authenticationProvider = Provider<Authentication>(
//   (ref) {
//     return Authentication();
//   },
// );

// final authStateProvider = StreamProvider<User?>(
//   (ref) {
//     return ref.watch(authenticationProvider).authStateChange;
//   },
// );

// class Authentication {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Stream of Firebase User
//   Stream<User?> get authStateChange => _auth.authStateChanges();

//   // Other authentication methods like signInWithEmailAndPassword, signUpWithEmailAndPassword, etc.
// }

final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authenticationProvider).authStateChange;
});
