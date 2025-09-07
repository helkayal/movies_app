import 'package:flutter/material.dart';
import 'package:movies_app/ui/screens/auth/forget_password/forget_password.dart';
import 'package:movies_app/ui/screens/home/home_screen.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/edit_profile.dart';
import 'package:movies_app/ui/screens/auth/login/login.dart';
import 'package:movies_app/ui/screens/on_boarding/onboarding.dart';
import 'package:movies_app/ui/screens/on_boarding/onboarding_intro.dart';
import 'package:movies_app/ui/screens/auth/register/register.dart';

abstract final class AppRoutes {
  static Route get onboardingIntro {
    return MaterialPageRoute(builder: (_) => const OnboardingIntro());
  }

  static Route get onboarding {
    return MaterialPageRoute(builder: (_) => Onboarding());
  }

  static Route get login {
    return MaterialPageRoute(builder: (_) => const LoginScreen());
  }

  static Route get register {
    return MaterialPageRoute(builder: (_) => const Register());
  }

  static Route get forgetPassword {
    return MaterialPageRoute(builder: (_) => const ForgetPassword());
  }

  static Route get home {
    return MaterialPageRoute(builder: (_) => const HomeScreen());
  }

  static Route get editProfile {
    return MaterialPageRoute(builder: (_) => const EditProfile());
  }

}
