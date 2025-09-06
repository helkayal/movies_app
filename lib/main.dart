// import 'package:firebase_core/firebase_core.dart';
// import 'package:movies_app/firebase_options.dart';

// // Screens
// import 'package:movies_app/ui/screens/auth/login/login.dart';
// import 'package:movies_app/ui/screens/on_boarding/onboarding_intro.dart';

// // Blocs & Cubits
// import 'package:movies_app/ui/screens/auth/authbloc/authbloc.dart';
// import 'package:movies_app/core/utils/constants/imports.dart';

// // APIs
// import 'package:movies_app/data/datasources/Api/authapi.dart';
// import 'package:movies_app/data/datasources/Api/dioclient.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   final dioClient = DioClient();
//   final authApis = AuthApis(dioClient);

//   // Onboarding check before runApp
//   final onboardingRepository = OnboardingRepositoryImpl(
//     OnboardingDataSourceImpl(),
//   );
//   final completed = await onboardingRepository.isOnboardingCompleted();

//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => MovieBloc()),
//         BlocProvider(create: (_) => ProfileCubit()),
//         BlocProvider(create: (_) => AuthBloc(authApis: authApis)),
//         BlocProvider(create: (_) => ChangeBgImageBloc()),
//       ],
//       child: MainApp(onboardingCompleted: completed),
//     ),
//   );
// }

// class MainApp extends StatelessWidget {
//   final bool onboardingCompleted;
//   const MainApp({super.key, required this.onboardingCompleted});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.dark,
//       darkTheme: AppTheme.darkTheme,
//       // Directly choose the start screen
//       home: onboardingCompleted ? const LoginScreen() : const OnboardingIntro(),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/firebase_options.dart';

// Screens
import 'package:movies_app/ui/screens/auth/login/login.dart';
import 'package:movies_app/ui/screens/on_boarding/onboarding_intro.dart';

// Blocs & Cubits
import 'package:movies_app/ui/screens/auth/authbloc/authbloc.dart';
import 'package:movies_app/core/utils/constants/imports.dart';

// APIs
import 'package:movies_app/data/datasources/Api/authapi.dart';
import 'package:movies_app/data/datasources/Api/dioclient.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dioClient = DioClient();
  final authApis = AuthApis(dioClient);

  final onboardingRepository = OnboardingRepositoryImpl(
    OnboardingDataSourceImpl(),
  );
  final completed = await onboardingRepository.isOnboardingCompleted();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieBloc()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => AuthBloc(authApis: authApis)),
        BlocProvider(create: (_) => ChangeBgImageBloc()),
      ],
      child: MainApp(onboardingCompleted: completed),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool onboardingCompleted;
  const MainApp({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
          home: child,
        );
      },
      child: onboardingCompleted
          ? const LoginScreen()
          : const OnboardingIntro(),
    );
  }
}
