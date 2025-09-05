import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/home/bloc/change_bg_image_bloc/change_bg_image_bloc.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_cubit.dart';
import 'core/theme/app_theme.dart';
import 'ui/screens/home/bloc/movie_bloc/movie_bloc.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/splash/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => MovieBloc(),),
      BlocProvider(create: (context) => ChangeBgImageBloc(),),
      BlocProvider(create: (context) => ProfileCubit()),
    ],
    child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      home: Splash(),
    );
  }
}
