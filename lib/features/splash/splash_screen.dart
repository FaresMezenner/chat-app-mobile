import 'package:chat_app/core/constants/routes.dart';
import 'package:chat_app/shared/logic/cubit/auth_cubit.dart';
import 'package:chat_app/features/socket_io/logic/cubit/socket_io_cubit.dart';
import 'package:chat_app/shared/logic/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  late final AuthState authState;
  late final BuildContext buildContext;

  void onRender(Duration duration) {
    Navigator.pushNamed(buildContext, Routes.login);
    if (!authState.connected) {
      Navigator.pushNamed(buildContext, Routes.login);
    } else {
      BlocProvider.of<SocketIoCubit>(buildContext).connect(authState.token!);
      Navigator.pushNamed(buildContext, Routes.profile);
    }
  }

  SplashScreen({super.key}) {
    SchedulerBinding.instance.addPostFrameCallback(onRender);
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    authState = BlocProvider.of<AuthCubit>(context).state;

    return Material(
      color: Theme.of(context).colorScheme.primary,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
