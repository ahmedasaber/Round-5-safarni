import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';
import '../widget/social_media_button.dart';
import '../../../home/presentation/views/pages/home_view.dart';
import '../../presentaion/pages/forget_password.dart';
import '../../presentaion/pages/sign_up.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  static const routeName = '/signIn-screen';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Loading...")),
              );
            } else if (state is AuthSuccess) {
              // ✅ هنا لغيت SnackBar اللي بيظهر بعد تسجيل الدخول
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeView.routeName,
                    (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.08),

                // Logo
                Center(
                  child: Image.asset(
                    "assets/images/llll.png",
                    height: height * 0.12,
                  ),
                ),
                SizedBox(height: height * 0.02),

                Center(
                  child: Text(
                    "Welcome Again",
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.05),

                CustomTextField(hint: "Email", controller: emailController),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  hint: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgetPasswordPage.routeName,
                      );
                    },
                    child: const Text("Forgot Password?"),
                  ),
                ),

                CustomButton(
                  text: state is AuthLoading ? "Loading..." : "Sign In",
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter email and password"),
                        ),
                      );
                      return;
                    }

                    /// استدعاء cubit.login
                    context.read<AuthCubit>().login(email, password);
                  },
                ),

                SizedBox(height: height * 0.03),

                // Social Buttons
                SocialAuthButtons(),

                const Spacer(),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpPage.routeName);
                    },
                    child: const Text("DON'T HAVE AN ACCOUNT? SIGN UP"),
                  ),
                ),
                SizedBox(height: height * 0.03),
              ],
            );
          },
        ),
      ),
    );
  }
}
