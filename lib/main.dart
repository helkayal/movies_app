import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies_app/ui/screens/auth/local_provider/local_provider.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  bool completed = false;
  bool loggedInBefore = false;

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  try {
    final dioClient = DioClient();
    final authApis = AuthApis(dioClient);

    final onboardingRepository = OnboardingRepositoryImpl(
      OnboardingDataSourceImpl(),
    );
    completed = await onboardingRepository.isOnboardingCompleted();

    final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final token = await secureStorage.read(key: 'token');

    if (token != null && token.isNotEmpty) {
      loggedInBefore = true;
    }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
          BlocProvider(create: (context) => MovieDetailsBloc()),
          BlocProvider(create: (_) => MovieBloc(apiService: ApiService())),
          BlocProvider(create: (_) => ProfileCubit()..getProfile()),
          BlocProvider(create: (_) => FavouriteCubit()..loadFavourites()),
          BlocProvider(create: (_) => HistoryCubit()..loadHistory()),
          BlocProvider(create: (_) => AuthBloc(authApis: authApis)),
          BlocProvider(create: (_) => ChangeBgImageBloc()),
        ],
        child: MainApp(
          onboardingCompleted: completed,
          loggedInBefore: loggedInBefore,
        ),
      ),
    );
  } catch (e) {
    // print("❌ Error before runApp: $e");
    return null;
  }
}

class MainApp extends StatelessWidget {
  final bool onboardingCompleted;
  final bool loggedInBefore;
  const MainApp({
    super.key,
    required this.onboardingCompleted,
    required this.loggedInBefore,
  });

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
          locale: localeProvider.locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: onboardingCompleted
              ? loggedInBefore
                    ? HomeScreen()
                    : const LoginScreen(key: Key('loginScreen'))
              : const OnboardingIntro(),
        );
      },
    );
  }
}
