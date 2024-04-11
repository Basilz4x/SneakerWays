import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/data/auth_repositroy.dart';
import 'package:sneakers_shop_app/pages/home_page.dart';
import 'package:sneakers_shop_app/widgets/custom_text_form_field.dart';
import 'package:sneakers_shop_app/widgets/sign_button.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_back_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                  "Sign In Now",
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
                  "Please sign in to continue using our app",
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColor.textColor.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                CustomTextFormField(
                  hint: "Email Address",
                  obscure: false,
                  icon: Icons.email_rounded,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomTextFormField(
                  hint: "Password",
                  obscure: false,
                  icon: Icons.lock_outline_rounded,
                  controller: _passwordController,
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
                    _loginProcess(context);
                  },
                  label: "Sign In",
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
    );
  }

  void _loginProcess(context) async {
    await ref.read(authRepositroyProvider).loginUser(
        email: _emailController.text, password: _passwordController.text);
    Navigator.pushReplacement(
      context,
      PageTransition(child: const HomePage(), type: PageTransitionType.fade),
    );
  }
}
