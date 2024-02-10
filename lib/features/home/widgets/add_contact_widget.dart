import 'package:chat_app/core/constants/enums/tables.dart';
import 'package:chat_app/features/home/logic/cubit/contacts_cubit.dart';
import 'package:chat_app/shared/services/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContact extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Add Contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String phone = _phoneController.text;
                BlocProvider.of<ContactsCubit>(context).addContact(phone);
              },
              child: const Text('Add'),
            ),
            const SizedBox(height: 20),
            BlocConsumer<ContactsCubit, ContactsState>(
              builder: (context, state) {
                if (state is AddContactLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AddContactError) {
                  return Text(
                    state.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              listener: (context, state) async {
                List<Map<String, dynamic>> contacts =
                    await SqliteHelper().getAll(Tables.contacts.getName());
                print("Contacts: $contacts");
                Navigator.of(context).pop();
              },
              listenWhen: (previous, current) => current is AddContactSuccess,
              buildWhen: (previous, current) => current is AddContactState,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
