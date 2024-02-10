import 'package:chat_app/features/home/widgets/add_contact_widget.dart';
import 'package:chat_app/features/home/bodies/contacts_body.dart';
import 'package:chat_app/features/home/logic/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void addContactPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddContact();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat app'),
      ),
      body: const Contacts(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addContactPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
