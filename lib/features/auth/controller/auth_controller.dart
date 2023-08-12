import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.read(authRepositoryProvider)));

class AuthController {
  final AuthRepository
      _authRepository; //this the class from features/auth/repository/auth_repository

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;
  void signInWithGoogle() {
    _authRepository.signInWithGoogle();
  }
}
