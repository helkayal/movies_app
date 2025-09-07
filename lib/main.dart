import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

// localization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dioClient = DioClient();
  final authApis = AuthApis(dioClient);

  final onboardingRepository = OnboardingRepositoryImpl(OnboardingDataSourceImpl());
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

class MainApp extends StatefulWidget {
  final bool onboardingCompleted;
  const MainApp({super.key, required this.onboardingCompleted});

  static _MainAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

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
          locale: _locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: widget.onboardingCompleted
              ? LoginScreen(
            key: const Key('loginScreen'),
            // تمرير setLocale لربطه مع LoginView
            onLocaleChange: setLocale,
          )
              : const OnboardingIntro(),
        );
      },
    );
  }
}
