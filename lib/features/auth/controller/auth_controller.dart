// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:reddit_tutorial/features/auth/repository/auth_repository.dart';

import '../../../core/utils.dart';
import '../../../models/user_model.dart';

// Define a StateProvider to manage user data
final userProvider = StateProvider<UserModel?>((ref) => null);

// Define a StateNotifierProvider for the AuthController class
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) => AuthController(
          authRepository: ref.watch(authRepositoryProvider),
          ref: ref,
        ));

// Define a StreamProvider to manage authentication state changes
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

// Define a StreamProvider.family to get user data for a specific UID
final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

// A class that manages authentication-related state
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository; // Instance of AuthRepository
  final Ref _ref; // Reference to the userProvider

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false); // Initialize with loading state

  // Stream that provides changes in authentication state
  Stream<User?> get authStateChange => _authRepository.authStateChange;

  // Method to sign in with Google authentication
  void signInWithGoogle(BuildContext context) async {
    state = false; // Set the loading state
    final user =
        await _authRepository.signInWithGoogle(); // Sign in with Google

    // Handle the result of the sign-in attempt using the Either monad
    user.fold(
        (l) => showSnackBar(context, l.message), // Show error message
        (UserModel userModel) => _ref
            .read(userProvider.notifier)
            .update((state) => userModel)); // Update userProvider state
  }

  // Method to get user data for a specific UID
  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
