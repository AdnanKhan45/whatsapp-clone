import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp_clone_app/features/user/domain/usecases/credential/sign_in_with_phone_number_usecase.dart';
import 'package:whatsapp_clone_app/features/user/domain/usecases/credential/verify_phone_number_usecsae.dart';
import 'package:whatsapp_clone_app/features/user/domain/usecases/user/create_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final CreateUserUseCase createUserUseCase;
  CredentialCubit({
    required this.signInWithPhoneNumberUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.createUserUseCase
}) : super(CredentialInitial());

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(CredentialPhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitSmsCode({required String smsCode}) async {
    try {
      await signInWithPhoneNumberUseCase.call(smsCode);
      emit(CredentialPhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitProfileInfo({required UserEntity user}) async {
    try {
      await createUserUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  }
