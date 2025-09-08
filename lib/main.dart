import 'package:movies_app/ui/screens/auth/local_provider/local_provider.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart'; // ✅ استدعاء Provider
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

// localization
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // ✅ ملف الـ Provider

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocaleProvider(),
        ), // ✅ Provider للـ Locale
        BlocProvider(create: (_) => MovieBloc(apiService: ApiService())),
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
    final localeProvider = Provider.of<LocaleProvider>(
      context,
    ); // ✅ جلب الـ Locale من الـ Provider

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
          locale: localeProvider.locale, // ✅ استخدام الـ Locale من الـ Provider
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: HomeScreen(),
          // onboardingCompleted
          //     ? const LoginScreen(
          //         key: Key('loginScreen'),
          //       ) // مش محتاجين onLocaleChange بعد كده
          //     : const OnboardingIntro(),
        );
      },
    );
  }
}
