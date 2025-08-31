import 'package:flutter/material.dart';
import 'package:movies_app/uitlies/Appassets.dart';
import 'package:movies_app/uitlies/Appcolor.dart';
import 'package:movies_app/uitlies/Appstyle.dart';

import '../uitlies/Approutes.dart';

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
        backgroundColor: AppColor.transferColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(Icons.arrow_back, color: AppColor.yellowColor),
          centerTitle: true,
          title: Text(
            'Forget Password',
            style: AppStyle.yellow14font,
          ),
        ),

        body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: height * 0.01),
                  Image.asset(AppAssets.forgotPassword),
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
                          fillColor: AppColor.blackFontColor,
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
                      backgroundColor: AppColor.yellowColor,
                      minimumSize: Size(width * 0.9, height * 0.07), // 👈 أكبر شوية
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Verify Email',
                      style: TextStyle(
                        color:AppColor.blackFontColor,
                        fontSize: 16,
                      ),
                    ),
                  ),

                ]))
    );
  }
}