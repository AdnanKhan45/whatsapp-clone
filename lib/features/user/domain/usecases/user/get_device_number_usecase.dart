
import 'package:whatsapp_clone_app/features/user/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_app/features/user/domain/repository/user_repository.dart';

class GetDeviceNumberUseCase {
  final UserRepository repository;

  GetDeviceNumberUseCase({required this.repository});

  Future<List<ContactEntity>> call() async {
    return repository.getDeviceNumber();
  }

}