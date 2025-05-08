import 'package:finance_news/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoadingStack extends StatelessWidget {
  const LoadingStack({
    super.key,
    required this.loadingProvider,
    required this.child,
    this.color = AppColor.primary600,
    this.progressIndicator = const CircularProgressIndicator(),
    this.opacity = 0.5,
  });

  final ProviderListenable<bool> loadingProvider;
  final Color color;
  final Widget progressIndicator;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Consumer(
            builder: (context, ref, child) {
              return Visibility(
                visible: ref.watch(loadingProvider),
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(opacity),
                  ),
                  child: progressIndicator,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
