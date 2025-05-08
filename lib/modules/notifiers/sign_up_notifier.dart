import 'package:finance_news/data/repos/user_repo.dart';
import 'package:finance_news/modules/models/sign_up_state.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier({required this.userRepo}) : super(SignUpState());
  UserRepo userRepo;

  void initialize() {
    state = SignUpState();
  }

  set firstName(String firstName) =>
      state = state.copyWith(firstName: firstName);

  set lastName(String lastName) => state = state.copyWith(lastName: lastName);

  set isFirstNameValidated(bool isValidated) =>
      state = state.copyWith(isFirstNameValidated: isValidated);

  set isLastNameValidated(bool isValidated) =>
      state = state.copyWith(isLastNameValidated: isValidated);

  void updateButton() {
    state = state.copyWith(
        isCompleted: state.isFirstNameValidated && state.isLastNameValidated);
  }

  Future<void> signUp() async {
    state = state.setLoading('');
    debugPrint('Signing Up');

    final response = await userRepo.saveUserCredentials(
      state.firstName.trim(),
      state.lastName.trim(),
    );
    state = state.copyWith(response: response);
  }
}
