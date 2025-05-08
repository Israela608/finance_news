import 'package:finance_news/common/loading_stack.dart';
import 'package:finance_news/common/plain_text_field.dart';
import 'package:finance_news/common/show_custom_snackbar.dart';
import 'package:finance_news/core/helper/navigation.dart';
import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:finance_news/core/utils/extensions.dart';
import 'package:finance_news/core/utils/utils.dart';
import 'package:finance_news/core/utils/validators.dart';
import 'package:finance_news/modules/providers/sign_up_provider.dart';
import 'package:finance_news/modules/screens/allow_notifications_screen.dart';
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
          floatingActionButton: NextButton(formKey: formKey),
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
      hintText: 'First name',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validatorCallback: Validators.validateAlpha(
        isValidated: (value) {
          signUpNotifier.isFirstNameValidated = value;
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

class LastNameBox extends HookConsumerWidget {
  const LastNameBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final signUpNotifier = ref.read(signUpNotifierProvider.notifier);

    return PlainTextField(
      textController: textController,
      hintText: 'Last name',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validatorCallback: Validators.validateAlpha(
        isValidated: (value) {
          signUpNotifier.isLastNameValidated = value;
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

class NextButton extends HookConsumerWidget {
  const NextButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCompleted = ref.watch(signUpNotifierProvider).isCompleted;

    return FloatingActionButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final signUpNotifier = ref.read(signUpNotifierProvider.notifier);
          await signUpNotifier.signUp();

          final response = ref.read(signUpNotifierProvider).response;

          if (response.isSuccess) {
            return Navigation.gotoWidget(
              context,
              replacePreviousScreen: true,
              AllowNotificationsScreen(),
            );
          } else {
            showCustomSnackBar(
              context,
              message: response.message,
            );
          }
        }
      },
      backgroundColor: isCompleted
          ? AppColor.primary600
          : AppColor.primary600.withOpacity(0.4),
      child: getSvg(
        svg: 'chevron-right',
        height: 24,
        width: 24,
      ),
    );
  }
}
