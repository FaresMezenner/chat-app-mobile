import 'package:chat_app/features/home/logic/cubit/contacts_cubit.dart';
import 'package:chat_app/features/home/widgets/contact_list_tile.dart';
import 'package:chat_app/shared/domaine/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (builderContext, state) {
        return RefreshIndicator(
          child: Builder(
            builder: (subBuilderContext) {
              if (state is ContactsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ContactsLoaded) {
                if (state.users.isNotEmpty) {
                  return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      MapEntry<User, Map<String, dynamic>> entry =
                          state.users[index].entries.first;
                      return ContactListTile(
                        user: entry.key,
                        lastMessageContent: entry.value["lastMessageContent"],
                        lastMessageSentDate: entry.value["lastMessageSentDate"],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No contacts found."),
                  );
                }
              } else if (state is ContactsError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox();
            },
          ),
          onRefresh: () => Future(
            () =>
                BlocProvider.of<ContactsCubit>(builderContext).fetchContacts(),
          ),
        );
      },
      buildWhen: (previous, current) => current is ContactsListState,
    );
  }
}
