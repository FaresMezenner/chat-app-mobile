import 'package:chat_app/shared/logic/cubit/auth_cubit.dart';
import 'package:chat_app/shared/widgets/error_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  late final BuildContext buildContext;
  ProfileScreen({super.key}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // showDialog(
      //   context: buildContext,
      //   builder: (BuildContext context) {
      //     return ErrorPopup(
      //       title: "Disconnected",
      //       message: "message",
      //       buttons: <TextButton>[
      //         TextButton(
      //           onPressed: () => print("message"),
      //           child: const Text('OK'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    String? token = BlocProvider.of<AuthCubit>(context).state.token;

    return Material(
      child: Center(
        child: Text(token ?? 'not connected'),
      ),
    );
  }
}
