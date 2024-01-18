import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/features/status/domain/entities/status_entity.dart';
import 'package:whatsapp_clone_app/features/status/domain/usecases/create_status_usecase.dart';
import 'package:whatsapp_clone_app/features/status/domain/usecases/delete_status_usecase.dart';
import 'package:whatsapp_clone_app/features/status/domain/usecases/get_statuses_usecase.dart';
import 'package:whatsapp_clone_app/features/status/domain/usecases/seen_status_update_usecase.dart';
import 'package:whatsapp_clone_app/features/status/domain/usecases/update_only_image_status_usecase.dart';

import '../../../domain/usecases/update_status_usecase.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  final CreateStatusUseCase createStatusUseCase;
  final DeleteStatusUseCase deleteStatusUseCase;
  final UpdateStatusUseCase updateStatusUseCase;
  final GetStatusesUseCase getStatusesUseCase;
  final UpdateOnlyImageStatusUseCase updateOnlyImageStatusUseCase;
  final SeenStatusUpdateUseCase seenStatusUpdateUseCase;
  StatusCubit({
    required this.getStatusesUseCase,
    required this.updateStatusUseCase,
    required this.deleteStatusUseCase,
    required this.createStatusUseCase,
    required this.updateOnlyImageStatusUseCase,
    required this.seenStatusUpdateUseCase,
}) : super(StatusInitial());

  Future<void> getStatuses({required StatusEntity status}) async {
    try {

      emit(StatusLoading());
      final streamResponse = getStatusesUseCase.call(status);
      streamResponse.listen((statuses) {
        print("statuses = $statuses");
        emit(StatusLoaded(statuses: statuses));
      });

    } on SocketException {
      emit(StatusFailure());
    } catch(_) {
      emit(StatusFailure());
    }
  }


  Future<void> createStatus({required StatusEntity status}) async {

    try {
      await createStatusUseCase.call(status);

    } on SocketException {
      emit(StatusFailure());
    } catch(_) {
      emit(StatusFailure());
    }
  }

  Future<void> deleteStatus({required StatusEntity status}) async {

    try {
      await deleteStatusUseCase.call(status);

    } on SocketException {
      emit(StatusFailure());
    } catch(_) {
      emit(StatusFailure());
    }
  }

  Future<void> updateStatus({required StatusEntity status}) async {

    try {
      await updateStatusUseCase.call(status);

    } on SocketException {
      emit(StatusFailure());
    } catch(_) {
      emit(StatusFailure());
    }
  }

  Future<void> updateOnlyImageStatus({required StatusEntity status}) async {

    try {
      await updateOnlyImageStatusUseCase.call(status);

    } on SocketException {
      emit(StatusFailure());
    } catch(_) {
      emit(StatusFailure());
    }
  }

  Future<void> seenStatusUpdate({required String statusId, required int imageIndex, required String userId}) async {

    try {
      await seenStatusUpdateUseCase.call(statusId, imageIndex, userId);

    } on SocketException {
      emit(StatusFailure());
    } catch(_) {
      emit(StatusFailure());
    }
  }
}
