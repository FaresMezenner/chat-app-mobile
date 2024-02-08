import 'package:chat_app/features/add_contact/widgets/add_contact_widget.dart';
import 'package:flutter/material.dart';

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
      body: const Center(
        child: Text('Home Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addContactPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
