import 'package:chat_app/shared/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = BlocProvider.of<AuthCubit>(context).state.token;
    return Material(
      child: Center(
        child: Text(token ?? 'not connected'),
      ),
    );
  }
}
