

import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => MovieBloc(apiService: ApiService()),),
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
      home: HomeScreen(),
    );
  }
}
