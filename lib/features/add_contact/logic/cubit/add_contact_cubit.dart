import 'package:chat_app/core/constants/errors/backend_erro.dart';
import 'package:chat_app/features/add_contact/domaine/repositories/fetch_user_repository.dart';
import 'package:chat_app/shared/logic/domaine/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../state/add_contact_state.dart';

class AddContactCubit extends Cubit<AddContactState> {
  AddContactCubit() : super(AddContactInitial());

  void addContact(phone) async {
    emit(AddContactLoading());
    try {
      User user = await FetchUserRepository.fetchUserByPhone(phone);
      emit(AddContactSuccess(user));
    } on BackendException catch (e) {
      emit(AddContactError(message: e.message));
    }
  }

  void declareWrongInput({String? message}) {
    emit(
      message == null
          ? AddContactErrorInput()
          : AddContactErrorInput(message: message),
    );
  }
}
