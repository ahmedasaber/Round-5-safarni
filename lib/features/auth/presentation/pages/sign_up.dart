import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';
import 'sign_in.dart';
import '../widget/social_media_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const routeName = '/signUp-screen';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
              Navigator.pushNamedAndRemoveUntil(
                context,
                SignInPage.routeName,
                    (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(   // ✅ Make the page scrollable
                child: ConstrainedBox(
                constraints: BoxConstraints(
                minHeight: height,  // ensures full height
            ),
            child: IntrinsicHeight(
                child: Column(
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
                      hint: "Confirm Password", 
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
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
