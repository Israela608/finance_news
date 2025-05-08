import 'package:finance_news/data/repos/user_repo.dart';
import 'package:finance_news/modules/models/sign_up_state.dart';
import 'package:finance_news/modules/notifiers/sign_up_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final userRepo = ref.watch(userRepoProvider);
  return SignUpNotifier(userRepo: userRepo);
});

final signUpLoadingProvider = Provider<bool>((ref) {
  final signUpState = ref.watch(signUpNotifierProvider);
  return signUpState.response.isLoading;
});
