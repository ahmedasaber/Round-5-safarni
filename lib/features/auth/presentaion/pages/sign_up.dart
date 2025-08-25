import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';
import '../../../home/presentation/views/pages/home_view.dart';
import '../../presentaion/pages/sign_in.dart';
import '../widget/social_media_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static const routeName = '/signUp-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController(); // ✨ جديد

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

                SizedBox(height: height * 0.02),

                Center(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Again",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "welcome back! please Fill Your data",
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.05),

                CustomTextField(hint: "Name", controller: nameController),
                SizedBox(height: height * 0.02),
                CustomTextField(hint: "Email", controller: emailController),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  hint: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  hint: "Confirm Password", // ✨ جديد
                  controller: confirmPasswordController,
                  obscureText: true,
                ),

                SizedBox(height: height * 0.02),

                Row(
                  children: [
                    Image.asset("assets/images/check-circle.png", height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text("Must be at least 8 characters"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/images/check-circle.png", height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text("Must contain one special character"),
                  ],
                ),

                SizedBox(height: height * 0.03),

                CustomButton(
                  text: state is AuthLoading ? "Loading..." : "Sign Up",
                  onPressed: () {
                    final name = nameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text.trim();

                    // ✅ Validation
                    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("All fields are required")),
                      );
                      return;
                    }

                    if (password.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password must be at least 8 characters")),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    // ✅ لو كله تمام
                    context.read<AuthCubit>().register(
                      name,
                      email,
                      password,
                      confirmPassword,
                    );
                  },
                ),

                SizedBox(height: height * 0.03),

                SocialAuthButtons(),

                const Spacer(),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignInPage.routeName);
                    },
                    child: const Text("Already have an account? Sign In"),
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
