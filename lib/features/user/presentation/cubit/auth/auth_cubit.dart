import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone_app/features/user/domain/usecases/credential/get_current_uid_usecase.dart';
import 'package:whatsapp_clone_app/features/user/domain/usecases/credential/is_sign_in_usecase.dart';
import 'package:whatsapp_clone_app/features/user/domain/usecases/credential/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.getCurrentUidUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase
}) : super(AuthInitial());

  Future<void> appStarted() async{

    try{
      bool isSignIn=await isSignInUseCase.call();

      if (isSignIn){
        final uid=await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      }else {
        emit(UnAuthenticated());
      }

    }catch(_){
      emit(UnAuthenticated());
    }

  }

  Future<void> loggedIn() async{
    try{
      final uid= await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async{
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      emit(UnAuthenticated());
    }
  }
}
