import 'package:movies_app/core/utils/constants/imports.dart';
import '../../../../data/datasources/google/google_auth.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authevent.dart';
import '../authbloc/authstate.dart';

class LoginView extends StatefulWidget {
  final bool isLoading;
  final GoogleAuth googleAuth = GoogleAuth();

  LoginView({super.key, this.isLoading = false});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            Image.asset(AppAssets.videologo),
            SizedBox(height: height * 0.09),

            // Email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SizedBox(
                width: width * 0.95,
                child: CustomTextField(
                  hint: 'Email',
                  controller: emailController,
                  prefixIcon: Image.asset(AppAssets.email),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),

            // Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SizedBox(
                width: width * 0.95,
                child: CustomTextField(
                  hint: "Password",
                  controller: passwordController,
                  prefixIcon: Image.asset(AppAssets.lock),
                  isPassword: true,
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
                    Navigator.pushReplacement(
                      context,
                      AppRoutes.forgetPassword,
                    );
                  },
                  child: Text(
                    'Forget Password?',
                    style: AppTextStyles.yelowRegular14,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),

            // Login Button (Bloc)
            // Login Button + Google Login
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(context, AppRoutes.home);
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                bool isLoading = state is AuthLoading;
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<AuthBloc>().add(
                                LoginRequested(
                                  emailController.text,
                                  passwordController.text,
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.9,
                          55,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Login', style: AppTextStyles.blackRegular20),
                    ),
                    SizedBox(height: height * 0.03),
                    // Create Account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: AppTextStyles.whiteRegular14,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              AppRoutes.register,
                            );
                          },
                          child: Text(
                            "Create One",
                            style: AppTextStyles.yelowBlack14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

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
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                            indent: 10,
                            endIndent: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<AuthBloc>().add(
                                GoogleLoginRequested(),
                              );
                            },
                      icon: Image.asset(
                        AppAssets.google,
                        height: 24,
                        width: 24,
                      ),
                      label: Text(
                        "Login with Google",
                        style: AppTextStyles.blackRegular20,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.9,
                          55,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: height * 0.02),
            const LanguageSwitcher(),
          ],
        ),
      ),
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
          color: AppColors.transperant,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.yellow, width: 2),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(AppAssets.eg),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(AppAssets.us),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isArabic
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.yellow, width: 4),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }
}
