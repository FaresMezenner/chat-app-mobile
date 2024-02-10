import 'package:chat_app/core/constants/enums/tables.dart';
import 'package:chat_app/core/constants/errors/backend_erro.dart';
import 'package:chat_app/features/home/domaine/repositories/contacts_provider.dart';
import 'package:chat_app/shared/domaine/models/message.dart';
import 'package:chat_app/shared/domaine/models/user.dart';
import 'package:chat_app/shared/domaine/repositories/messages_repository.dart';
import 'package:chat_app/shared/services/sqlite_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsLoading()) {
    fetchContacts();
  }

  void fetchContacts() async {
    emit(ContactsLoading());
    _fetchContacts();
  }

  Future<void> receiveMessage(Message message) async {
    try {
      List contacts = await SqliteHelper()
          .getByField("id", message.contact, Tables.contacts);

      if (contacts.isEmpty) {
        User user = await ContactsRepository.fetchUser({
          "id": message.contact,
        });
        await SqliteHelper().insert(
          user.toMap(),
          Tables.contacts.getName(),
        );
      }
      int lastId = await MessagesRepository.addMessage(message);

      _fetchContacts();
    } catch (e) {
      print(e);
    }
  }

  void addContact(phone) async {
    emit(AddContactLoading());
    try {
      if (phone.isEmpty) {
        declareWrongInput();
        return;
      }

      List users =
          await SqliteHelper().getByField("phone", phone, Tables.contacts);
      if (users.isNotEmpty) {
        declareWrongInput(message: "Contact already exists.");
        return;
      }
      User user = await ContactsRepository.fetchUserByPhone(phone);
      await SqliteHelper().insert(
        user.toMap(),
        Tables.contacts.getName(),
      );
      emit(AddContactSuccess(user));
      _fetchContacts();
    } on BackendException catch (e) {
      emit(AddContactError(message: e.message));
    } catch (e) {
      print("Error: $e");
      emit(AddContactError(message: "An error occurred."));
    }
  }

  void declareWrongInput({String? message}) {
    emit(
      message == null
          ? AddContactErrorInput()
          : AddContactErrorInput(message: message),
    );
  }

  void _fetchContacts() async {
    try {
      List<Map<User, Map<String, dynamic>>> users =
          await ContactsRepository.fetchAllContactsWithLastMessage();
      emit(ContactsLoaded(users: users));
    } catch (e) {
      emit(ContactsError(message: "An error occurred."));
    }
  }
}
