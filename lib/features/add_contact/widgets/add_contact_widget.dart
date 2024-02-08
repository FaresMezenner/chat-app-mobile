import 'package:chat_app/features/add_contact/logic/cubit/add_contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContact extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddContactCubit(),
      child: Builder(builder: (subContext) {
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
                    if (phone.isNotEmpty) {
                      BlocProvider.of<AddContactCubit>(subContext)
                          .addContact(phone);
                    } else {
                      BlocProvider.of<AddContactCubit>(subContext)
                          .declareWrongInput();
                    }
                  },
                  child: const Text('Add'),
                ),
                const SizedBox(height: 20),
                BlocBuilder<AddContactCubit, AddContactState>(
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
