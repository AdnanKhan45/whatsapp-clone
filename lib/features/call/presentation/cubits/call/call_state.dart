part of 'call_cubit.dart';

abstract class CallState extends Equatable {
  const CallState();
}

class CallInitial extends CallState {
  @override
  List<Object> get props => [];
}

class IsCalling extends CallState {
  @override
  List<Object> get props => [];
}

class CallDialed extends CallState {
  final CallEntity userCall;

  CallDialed({required this.userCall});
  @override
  List<Object> get props => [userCall];
}

class CallFailed extends CallState {
  @override
  List<Object> get props => [];
}
