import 'package:equatable/equatable.dart';
import 'package:finance_news/data/models/response.dart';

class SignUpState extends Equatable {
  final Response response;
  final bool isCompleted;
  final bool isFirstNameValidated;
  final bool isLastNameValidated;
  final String firstName;
  final String lastName;

  SignUpState setLoading(String message) {
    return copyWith(response: Response.loading(message));
  }

  SignUpState({
    this.response = const Response.initial(),
    this.isCompleted = false,
    this.isFirstNameValidated = false,
    this.isLastNameValidated = false,
    this.firstName = '',
    this.lastName = '',
  });

  SignUpState copyWith({
    Response? response,
    bool? isCompleted,
    bool? isFirstNameValidated,
    bool? isLastNameValidated,
    String? firstName,
    String? lastName,
  }) {
    return SignUpState(
      response: response ?? this.response,
      isCompleted: isCompleted ?? this.isCompleted,
      isFirstNameValidated: isFirstNameValidated ?? this.isFirstNameValidated,
      isLastNameValidated: isLastNameValidated ?? this.isLastNameValidated,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  List<Object> get props => [
        response,
        isCompleted,
        isFirstNameValidated,
        isLastNameValidated,
        firstName,
        lastName,
      ];
}
