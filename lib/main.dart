import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/auth/login/login.dart';
import 'ui/screens/auth/authbloc/authbloc.dart';
import 'ui/screens/home/tabs/profile_tab/cubit/profile_cubit.dart';
import 'ui/screens/splash/splash.dart';
import 'ui/utils/app_theme.dart';
import 'data/bloc/bloc/movie_bloc.dart';

import 'authapi/authapi.dart';
import 'authapi/dioclient.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  final dioClient = DioClient();
  final authApis = AuthApis(dioClient);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieBloc()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => AuthBloc(authApis: authApis)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      home:  LoginScreen(),
    );
  }
}
