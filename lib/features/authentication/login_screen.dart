import 'package:chat_app/core/constants/endpoints.dart';
import 'package:chat_app/core/constants/routes.dart';
import 'package:chat_app/shared/logic/cubit/auth_cubit.dart';
import 'package:chat_app/shared/services/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    final String phone = phoneController.text;
    final String password = passwordController.text;

    DioHelper.getData(path: Endpoints.auth, headers: {
      'phone': phone,
      'password': password,
    }).then((response) {
      if (response.statusCode == 200) {
        BlocProvider.of<AuthCubit>(context).connect(response.data['token']);
        Navigator.pushNamed(context, Routes.profile);
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                ),
                controller: phoneController,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => login(context),
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Routes.register),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
