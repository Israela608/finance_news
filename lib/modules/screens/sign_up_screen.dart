import 'package:finance_news/common/loading_stack.dart';
import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:finance_news/core/utils/extensions.dart';
import 'package:finance_news/core/utils/validators.dart';
import 'package:finance_news/modules/providers/sign_up_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return LoadingStack(
      loadingProvider: signUpLoadingProvider,
      child: KeyboardDismissOnTap(
        child: Scaffold(
          backgroundColor: AppColor.secondary50,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    top: 10.h,
                    bottom: 10.h,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Text(
                    'Your legal name',
                    style: AppStyle.titleStyle(context),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //const HeightSpacer(height: 80),
                            16.height,
                            Text(
                              'Paginated Real-Time News',
                              style: AppStyle.subtitleStyle(context),
                            ),
                            24.height,
                            FirstNameBox(),
                            33.height,
                            LastNameBox(),
                            138.height,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstNameBox extends HookConsumerWidget {
  const FirstNameBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    return PlainTextField(
      textController: textController,
      hintText: 'Full name',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validatorCallback: Validators.validateAlpha(
        isValidated: (value) {
          signUpNotifier.isFullNameValidated = value;
        },
        function: signUpNotifier.updateButton,
      ),
      onChangedCallback: (value) {
        signUpNotifier.firstName = value;
      },
      onSavedCallback: (value) {
        signUpNotifier.firstName = value ?? '';
      },
    );
  }
}

class PhoneBox extends HookConsumerWidget {
  const PhoneBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    return PhoneTextField(
      textController: textController,
      hintText: 'Phone Number',
      textInputAction: TextInputAction.next,
      onValidatedCallback: (bool value) {
        debugPrint(value.toString()); //true if input is validated, false if not
        signUpNotifier.isPhoneValidated = value;
        signUpNotifier.updateButton;
      },
      onChangedCallback: (value) {
        signUpNotifier.phone = value;
      },
      onSavedCallback: (value) {
        debugPrint(value.toString());
        signUpNotifier.phone = value ?? '';
      },
    );
  }
}

class EmailBox extends HookConsumerWidget {
  const EmailBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    return PlainTextField(
      textController: textController,
      hintText: 'Email Address',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validatorCallback: Validators.validateEmail(
        isValidated: (value) {
          signUpNotifier.isEmailValidated = value;
        },
        function: signUpNotifier.updateButton,
      ),
      onChangedCallback: (value) {
        signUpNotifier.lastName = value;
      },
      onSavedCallback: (value) {
        signUpNotifier.lastName = value ?? '';
      },
    );
  }
}

class PasswordBox extends HookConsumerWidget {
  const PasswordBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final isObscure = useState(true);
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    return PasswordTextField(
      textController: textController,
      hintText: 'Password',
      isObscure: isObscure.value,
      onObscurePressedCallback: () {
        isObscure.value = !isObscure.value;
      },
      textInputAction: TextInputAction.next,
      validatorCallback: Validators.validatePassword(
        isValidated: (value) {
          signUpNotifier.isPasswordValidated = value;
        },
        function: signUpNotifier.updateButton,
      ),
      onChangedCallback: (value) {
        signUpNotifier.password = value;
      },
      onSavedCallback: (value) {
        signUpNotifier.password = value ?? '';
      },
    );
  }
}

class ConfirmPasswordBox extends HookConsumerWidget {
  const ConfirmPasswordBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final isObscure = useState(true);
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);
    final signUpState = ref.watch(signUpNotifierProvider);

    return PasswordTextField(
      textController: textController,
      hintText: 'Confirm Password',
      isObscure: isObscure.value,
      onObscurePressedCallback: () {
        isObscure.value = !isObscure.value;
      },
      textInputAction: TextInputAction.done,
      validatorCallback: Validators.validateConfirmPassword(
        password: signUpState.password,
        isValidated: (value) {
          signUpNotifier.isConfirmPasswordValidated = value;
        },
        function: signUpNotifier.updateButton,
      ),
      onChangedCallback: (value) {
        signUpNotifier.confirmPassword = value;
      },
      onSavedCallback: (value) {
        signUpNotifier.confirmPassword = value ?? '';
      },
    );
  }
}

class GoogleSignUp extends HookConsumerWidget {
  const GoogleSignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GoogleButton(
      onPress: () async {
        final signUpNotifier = ref.read(signUpNotifierProvider.notifier);
        await signUpNotifier.signUpWithGoogle(isPatient: true);

        final signUpState = ref.read(signUpNotifierProvider);
        final credentials = ref.read(userCredentialsProvider);
        if (signUpState.isSuccess) {
          signInNavigation(context, credentials: credentials, ref: ref);
        } else {
          showCustomSnackBar(context, message: signUpState.response.message);
        }
      },
    );
  }
}

class NextButton extends HookConsumerWidget {
  const NextButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WideButton(
      text: 'Next',
      //isEnabled: model.isCompleted,
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final signUpNotifier = ref.read(signUpNotifierProvider.notifier);
          await signUpNotifier.signUp(isPatient: true);

          final signUpState = ref.read(signUpNotifierProvider);
          if (signUpState.isSuccess) {
            return Navigation.gotoWidget(
              context,
              // replacePreviousScreen: true,
              OtpScreen(
                lastName: signUpState.lastName.toLowerCase().trim(),
              ),
            );
          } else {
            showCustomSnackBar(context, message: signUpState.response.message);
          }
        }
      },
    );
  }
}

class SignInText extends StatelessWidget {
  const SignInText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          getSvg(
            svg: 'arrow-left',
            height: 16.59,
            width: 16.59,
            color: AppThemes.darkButton(context),
          ),
          WidthSpacer(width: 2.41),
          Text.rich(
            TextSpan(
              style: AppStyle.labelStyleBold(context),
              children: [
                TextSpan(
                  text: "Already have an account?",
                ),
                TextSpan(
                  text: ' Sign in ',
                  style: AppStyle.labelStyleBlueBold(context),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigation.gotoWidget(
                        context,
                        SignInScreen(),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
