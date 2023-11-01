
import 'package:whatsapp_clone_app/features/user/domain/repository/user_repository.dart';

class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }

}