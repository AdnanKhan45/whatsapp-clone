part of 'my_call_history_cubit.dart';

abstract class MyCallHistoryState extends Equatable {
  const MyCallHistoryState();
}

class MyCallHistoryInitial extends MyCallHistoryState {
  @override
  List<Object> get props => [];
}

class MyCallHistoryLoading extends MyCallHistoryState {
  @override
  List<Object> get props => [];
}
class MyCallHistoryLoaded extends MyCallHistoryState {
  final List<CallEntity> myCallHistory;

  MyCallHistoryLoaded({required this.myCallHistory});
  @override
  List<Object> get props => [myCallHistory];
}

class MyCallHistoryFailure extends MyCallHistoryState {
  @override
  List<Object> get props => [];
}
