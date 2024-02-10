part of '../cubit/contacts_cubit.dart';

abstract class ContactsState extends Equatable {}

/**** Contacts list states */

class ContactsListState extends ContactsState {
  @override
  List<Object?> get props => [];
}

class ContactsLoading extends ContactsListState {
  @override
  List<Object?> get props => [];
}

class ContactsLoaded extends ContactsListState {
  final List<Map<User, Map<String, dynamic>>> users;

  ContactsLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class ContactsError extends ContactsListState {
  final String message;

  ContactsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ContactsNewMessage extends ContactsState {
  final Message message;

  ContactsNewMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

/**** Add contact states *****/

abstract class AddContactState extends ContactsState {}

class AddContactInitial extends AddContactState {
  @override
  List<Object?> get props => [];
}

class AddContactLoading extends AddContactState {
  @override
  List<Object?> get props => [];
}

class AddContactSuccess extends AddContactState {
  final User user;

  AddContactSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AddContactError extends AddContactState {
  final String message;

  AddContactError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddContactErrorInput extends AddContactError {
  AddContactErrorInput({super.message = "Please enter a valid phone number."});
}
