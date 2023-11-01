

import 'package:whatsapp_clone_app/features/user/domain/entities/contact_entity.dart';
import 'package:whatsapp_clone_app/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {

  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> signInWithPhoneNumber(String smsPinCode);

  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUID();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Stream<List<UserEntity>> getAllUsers();
  Stream<List<UserEntity>> getSingleUser(String uid);

  Future<List<ContactEntity>> getDeviceNumber();
}