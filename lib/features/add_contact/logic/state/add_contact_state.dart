part of '../cubit/add_contact_cubit.dart';

abstract class AddContactState {}

class AddContactInitial extends AddContactState {}

class AddContactLoading extends AddContactState {}

class AddContactSuccess extends AddContactState {
  final User user;

  AddContactSuccess(this.user);
}

class AddContactError extends AddContactState {
  final String message;

  AddContactError({required this.message});
}

class AddContactErrorInput extends AddContactError {
  AddContactErrorInput({super.message = "Please enter a valid phone number."});
}

// class AddContactFailure extends AddContactError {
//   AddContactFailure({required super.message});
// }
