

// ignore_for_file: unused_field

import 'dart:async';

import 'package:micro_core/micro_core.dart';
import 'dart:developer' as dev;
import '../../domain/entities/user.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/sign_out.dart';
import '../../repository/authentication_repository.dart';

part 'state.dart';
part 'event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  late StreamSubscription<AuthenticationStatus> _controller;
  final CurrentUserUsecase _currentUserUsecase;
  final SignOutUsecase _signOutUsecase;
  AuthenticationBloc({
    required Stream<AuthenticationStatus> controller,
    required SignOutUsecase signOutUsecase,
    required CurrentUserUsecase currentUserUsecase,
  })  : _signOutUsecase = signOutUsecase,
        _currentUserUsecase = currentUserUsecase,
        super(const AuthenticationState(
            status: AuthenticationStatus(null, StatusAuthentication.unknow))) {
    on<AuthenticationSignOutEvent>(_signOut);
    on<AuthenticationChangeStatusEvent>(_changeStatus);
    on<AuthenticationCurrentUserEvent>(_isCurrentUser);

    _controller = controller.listen((status) {
      dev.log("status: $status");
      add(AuthenticationChangeStatusEvent(status));
    });
  }

  Future<void> _signOut(AuthenticationSignOutEvent event,
      Emitter<AuthenticationState> emit) async {
    await _signOutUsecase();
  }

  Future<void> _changeStatus(AuthenticationChangeStatusEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  Future<void> _isCurrentUser(AuthenticationCurrentUserEvent event,
      Emitter<AuthenticationState> emit) async {
    await _currentUserUsecase();
  }
}
