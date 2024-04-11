import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/data/auth_repositroy.dart';
import 'package:sneakers_shop_app/data/user_repository.dart';
import 'package:sneakers_shop_app/models/app_user.dart';
import 'package:sneakers_shop_app/pages/home_page.dart';
import 'package:sneakers_shop_app/widgets/custom_text_form_field.dart';
import 'package:sneakers_shop_app/widgets/sign_button.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_back_button.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CustomBackButton(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign Up Now",
                    style: context.textTheme.headlineSmall!.copyWith(
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 3,
                    width: 70,
                    color: AppColor.secondaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please sign up to continue using our app",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: AppColor.textColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  CustomTextFormField(
                    hint: "Full Name",
                    obscure: false,
                    icon: Icons.face,
                    controller: _fullNameController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hint: "Email Address",
                    obscure: false,
                    icon: Icons.email,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hint: "Password",
                    obscure: false,
                    icon: Icons.lock_outline_rounded,
                    controller: _passwordController,
                    validtor: _validatePassword,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextFormField(
                    hint: "Confirm Password",
                    obscure: false,
                    icon: Icons.lock_outline_rounded,
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Forgot Password",
                      style: context.textTheme.titleMedium!.copyWith(
                          color: AppColor.secondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SignButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _signUpProcess(context);
                      }
                    },
                    label: "Sign Up",
                    labelColor: AppColor.backgroundColor,
                    color: AppColor.secondaryColor,
                    borderColor: AppColor.secondaryColor,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account?",
                          style: context.textTheme.titleMedium!.copyWith(
                            color: AppColor.textColor.withOpacity(0.5),
                          )),
                      TextSpan(
                          text: " Sign Up",
                          style: context.textTheme.titleMedium!.copyWith(
                            color: AppColor.secondaryColor,
                          )),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUpProcess(context) async {
    final auth = FirebaseAuth.instance;
    await ref.read(authRepositroyProvider).createUser(
          email: _emailController.text,
          password: _passwordController.text,
        );

    if (auth.currentUser != null) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final user = AppUser(
        uid: uid,
        fullName: _fullNameController.text,
        email: _emailController.text,
        image: "",
      );
      await ref.read(userRepositoryProvider).addUser(user: user);
      Navigator.pushReplacement(
        context,
        PageTransition(child: const HomePage(), type: PageTransitionType.fade),
      );
    } else {
      throw Exception("error in register");
    }
  }

  String? _validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    } else {
      if (!regex.hasMatch(value)) {
        return "Enter a valid password";
      } else {
        return null;
      }
    }
  }
}
