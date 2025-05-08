import 'package:finance_news/core/utils/constants.dart';
import 'package:finance_news/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(AppConst.kWidth, AppConst.kHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Finance News',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: child!,
        );
      },
      child: AuthWrapper(),
    );
  }
}

class AuthWrapper extends HookConsumerWidget {
  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSplashComplete = useState(false);
    final credentials = ref.watch(userCredentialsProvider);

    useEffect(() {
      // Show Splash for 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        isSplashComplete.value = true;
      });
      return null;
    }, []);

    if (!isSplashComplete.value) return SplashScreen();

    if (!_isOnboardingViewed) return OnboardingScreen();

    if (credentials.setupIncomplete) {
      return WelcomeScreen();
    }

    if (credentials.userType != null) return PinLoginScreen();

    return const Scaffold(
      body: CustomLoader(),
    );
  }
}
