import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/forget_password/forget_password.dart';
import 'package:movies_app/ui/screens/home/home.dart';
import 'package:movies_app/ui/screens/login/login.dart';
import 'package:movies_app/ui/screens/on_boarding/onboarding.dart';
import 'package:movies_app/ui/screens/register/register.dart';

abstract final class AppRoutes {
  static Route get onboarding {
    return MaterialPageRoute(builder: (_) => const Onboarding());
  }

  static Route get login {
    return MaterialPageRoute(builder: (_) => const Login());
  }

  static Route get register {
    return MaterialPageRoute(builder: (_) => const Register());
  }

  static Route get forgetPassword {
    return MaterialPageRoute(builder: (_) => const ForgetPassword());
  }

  static Route get home {
    return MaterialPageRoute(builder: (_) => const Home());
  }
}
