import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/core/utils/constants/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isArabic = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor:Colors.transparent,
        body: SingleChildScrollView(
            child: Column(
                children: [
                  // اللوجو
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.1),
                    child: Image.asset(AppAssets.logo),
                  ),

                  SizedBox(height: height * 0.09),

                  // 📧 TextField الإيميل
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          filled: true,
                          fillColor: AppColors.black,
                          prefixIcon: Image.asset(AppAssets.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.026),

                  // 🔑 TextField الباسورد
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          filled: true,
                          fillColor: AppColors.black,
                          prefixIcon: Image.asset(AppAssets.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                            const BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // Forget Password
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, AppRoutes.forgetPassword);
                        },
                        child:  Text(
                            'Forget Password?',
                            style: TextStyle(
                                color: AppColors.yellow,
                                fontSize: 12
                            )
                        ),
                      ),

                    ),
                  ),


                  SizedBox(height: height * 0.03),

                  // زرار Login
                  ElevatedButton(
                    onPressed: () {
                      print("Email :${emailController.text}");
                      print("Password :${passwordController.text}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      minimumSize: Size(width * 0.9, height * 0.07), // 👈 أكبر شوية
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:GestureDetector(
                      onTap: () {
                        // Navigator.push(context, AppRoutes.MovieDetialsRouteName);
                      },
                      child:  Text(
                        'Login',
                        style: AppTextStyles.blackBold20,
                      ),
                    ),


                  ),

                  SizedBox(height: height * 0.03),

                  // Create Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, AppRoutes.register);
                        },
                        child: Text(
                          "Create One",
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: AppColors.yellow,
                          thickness: 1,
                          indent: width * 0.05,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: AppColors.yellow, fontSize: 14),
                      ),
                      Expanded(
                        child: Divider(
                          color:AppColors.yellow,
                          thickness: 1,
                          indent: 10,
                          endIndent: width * 0.05,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.03),

// 🔹 زرار Login with Google
                  ElevatedButton.icon(
                    onPressed: () {
                      print("Login with Google");
                    },
                    icon: Image.asset(
                      AppAssets.google,
                      height: 24,
                      width: 24,
                    ),
                    label: Text(
                      "Login with Google",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      minimumSize: Size(width * 0.9, height * 0.065),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.02,),
                  const LanguageSwitcher(),  // 👈 هنا السويتش

                ]))
    );
  }
}
class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          isArabic = !isArabic;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width * 0.26,
        height: height * 0.05,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.yellow,
            width: 2,
          ),
        ),
        child: Stack(
          children: [

            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                AppAssets.icAr,
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AppAssets.icEn,
              ),
            ),


            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment:
              isArabic ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.yellow,
                    width: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}