import 'package:chat_app/core/constants/endpoints.dart';
import 'package:chat_app/core/constants/routes.dart';
import 'package:chat_app/shared/services/dio_helper.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register() {
    final String name = nameController.text;
    final String phone = phoneController.text;
    final String password = passwordController.text;

    DioHelper.postData(path: Endpoints.auth, data: {
      'name': name,
      'phone': phone,
      'password': password,
    }).then((response) {
      print(response.data);
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
                  labelText: 'Name',
                ),
                controller: nameController,
              ),
              const SizedBox(height: 20),
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
                onPressed: register,
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () => Navigator.pushNamed(context, Routes.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
