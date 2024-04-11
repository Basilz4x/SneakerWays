import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/pages/login_page.dart';
import 'package:sneakers_shop_app/pages/sign_up_page.dart';
import 'package:sneakers_shop_app/widgets/sign_button.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 110,
            left: -120,
            child: Transform.rotate(
              angle: pi / 4.5,
              child: Image.asset(
                "lib/images/dots.png",
                color: AppColor.backgroundColor,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: -130,
            child: Transform.rotate(
              angle: pi / 4.5,
              child: Image.asset(
                "lib/images/dots.png",
                color: AppColor.backgroundColor,
              ),
            ),
          ),
          Positioned(
            bottom: 240,
            right: -130,
            child: Transform.rotate(
              angle: pi / 4.5,
              child: Image.asset(
                "lib/images/dots.png",
                color: AppColor.backgroundColor,
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 100,
            child: Transform.scale(
              scale: 1.7,
              child: Image.asset(
                "lib/images/sneaker-logo.png",
                color: AppColor.backgroundColor,
                width: 250,
              ),
            ),
          ),
          Positioned(
            top: 455,
            left: 110,
            child: Text(
              "SNEAKERS",
              style: context.textTheme.headlineMedium!.copyWith(
                  color: AppColor.backgroundColor, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SignButton(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                      label: "Sign In",
                      labelColor: AppColor.secondaryColor,
                      color: AppColor.backgroundColor,
                      borderColor: AppColor.backgroundColor),
                  const SizedBox(
                    height: 18,
                  ),
                  SignButton(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SignUpPage();
                        }));
                      },
                      label: "Sign Up",
                      labelColor: AppColor.backgroundColor,
                      color: AppColor.secondaryColor,
                      borderColor: AppColor.backgroundColor),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
