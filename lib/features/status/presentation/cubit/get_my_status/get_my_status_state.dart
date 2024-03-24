part of 'get_my_status_cubit.dart';

abstract class GetMyStatusState extends Equatable {
  const GetMyStatusState();
}

class GetMyStatusInitial extends GetMyStatusState {
  @override
  List<Object> get props => [];
}

class GetMyStatusLoading extends GetMyStatusState {
  @override
  List<Object> get props => [];
}


class GetMyStatusLoaded extends GetMyStatusState {
  final StatusEntity? myStatus;

  const GetMyStatusLoaded({this.myStatus});
  @override
  List<Object?> get props => [myStatus];
}


class GetMyStatusFailure extends GetMyStatusState {
  @override
  List<Object> get props => [];
}

