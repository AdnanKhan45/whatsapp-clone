
import 'package:whatsapp_clone_app/features/user/domain/repository/user_repository.dart';

class SignInWithPhoneNumberUseCase {
  final UserRepository repository;

  SignInWithPhoneNumberUseCase({required this.repository});

  Future<void> call(String smsPinCode) async {
    return repository.signInWithPhoneNumber(smsPinCode);
  }

}