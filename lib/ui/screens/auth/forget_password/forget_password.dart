import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isArabic = true;
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(Icons.arrow_back, color: AppColors.yellow),
          centerTitle: true,
          title: Text(
            'Forget Password',
            style: AppTextStyles.yelowRegular14,
          ),
        ),

        body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: height * 0.01),
                  Image.asset(AppAssets.forgetPassword),
                  SizedBox(height: height * 0.04),
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
                            fontSize: 14,
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

                  SizedBox(height: height * 0.03),

                  ElevatedButton(
                    onPressed: () {
                      print("Email :${emailController.text}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellow,
                      minimumSize: Size(width * 0.9, height * 0.07), // 👈 أكبر شوية
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Verify Email',
                      style: TextStyle(
                        color:AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ]))
    );
  }
}