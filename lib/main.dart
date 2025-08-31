import 'package:flutter/material.dart';
import 'package:movies_app/ui/forgetpassword.dart';
import 'package:movies_app/ui/loginscreen.dart';
import 'package:movies_app/ui/register.dart';
import 'package:movies_app/uitlies/Approutes.dart';
import 'moviedetials/moviedetials.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.LoginScreenRouteName,
      routes: {
        AppRoutes.LoginScreenRouteName:(context)=>LoginScreen(),
        AppRoutes.RegisterRouteName:(context)=>Register(),
        AppRoutes.ForgetPasswordRouteName:(context)=>ForgetPassword(),
        AppRoutes.MovieDetialsRouteName:(context)=>MovieDetials(),
      },
      theme: ThemeData.dark(),
      );
  }
}
