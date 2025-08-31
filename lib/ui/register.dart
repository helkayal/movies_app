import 'package:flutter/material.dart';
import 'package:movies_app/uitlies/Appassets.dart';
import 'package:movies_app/uitlies/Appcolor.dart';
import 'package:movies_app/uitlies/Appstyle.dart';

import '../uitlies/Approutes.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isArabic = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController ConfirmpasswordController = TextEditingController();
  bool _obscurePassword = true;

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
            'Register',
            style: AppStyle.yellow14font,
          ),
        ),

        body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: height * 0.03),
                  Image.asset(AppAssets.register),
                  SizedBox(height: height * 0.01),
                  Text('Avatar',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 14
                    ),
                  ),

                  SizedBox(height: height * 0.01),
                  //name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColor.blackFontColor,
                          prefixIcon: Image.asset(AppAssets.name),
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

                  SizedBox(height: height * 0.02),

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
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColor.blackFontColor,
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

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        controller: ConfirmpasswordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColor.blackFontColor,
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

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: SizedBox(
                      width: width * 0.95,
                      child: TextField(
                        controller: phonenumber,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          hintStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColor.blackFontColor,
                          prefixIcon: Image.asset(AppAssets.call),
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


                  ElevatedButton(
                    onPressed: () {
                      print("Name :${nameController.text}");
                      print("Email :${emailController.text}");
                      print("Password :${passwordController.text}");
                      print("Confirm Password :${ConfirmpasswordController.text}");
                      print("Phone Number :${phonenumber.text}");

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.yellowColor,
                      minimumSize: Size(width * 0.9, height * 0.07), // 👈 أكبر شوية
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color:AppColor.blackFontColor,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.01),

                  // Create Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have Account ? ",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, AppRoutes.LoginScreenRouteName);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColor.yellowColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
          color: AppColor.transferColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColor.yellowColor,
            width: 2,
          ),
        ),
        child: Stack(
          children: [

            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                AppAssets.EG,
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AppAssets.En,
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
                    color: AppColor.yellowColor,
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
