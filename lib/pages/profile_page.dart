import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/data/user_repository.dart';
import 'package:sneakers_shop_app/models/app_user.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_back_button.dart';
import 'package:sneakers_shop_app/widgets/custom_drawer.dart';
import 'package:sneakers_shop_app/widgets/profile_text_form_field.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends ConsumerState<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool isEditable = false;
  bool isLoading = true;

  @override
  void initState() {
    _getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDataAsync =
        ref.watch(userDataProvider(FirebaseAuth.instance.currentUser!.uid));

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: !isLoading
            ? userDataAsync.when(
                data: (userSnapShot) {
                  final userData = userSnapShot.data();
                  if (userData != null) {
                    final currentUser =
                        AppUser.fromJson(userData as Map<String, dynamic>);

                    return Stack(
                      children: [
                        Container(
                          color: AppColor.backgroundColor,
                          height: double.infinity,
                        ),
                        Container(
                          height: 220,
                          decoration: const BoxDecoration(
                              color: AppColor.secondaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.elliptical(180, 90),
                                bottomRight: Radius.elliptical(180, 90),
                              )),
                        ),
                        const SafeArea(
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 18),
                                child: CustomBackButton())),
                        Positioned(
                          left: screenWidth / 2 - 43,
                          top: screenHeight / 1 / 2.7,
                          child: CircleAvatar(
                            foregroundImage: currentUser.image.isNotEmpty
                                ? MemoryImage(base64Decode(currentUser.image))
                                : null,
                            radius: 50,
                            child: isEditable
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(userRepositoryProvider)
                                            .updateUserImage();
                                      },
                                      child: Icon(
                                        Icons.photo,
                                        size: 42,
                                        color:
                                            AppColor.textColor.withOpacity(0.5),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        Positioned(
                          top: 270,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              ProfileTextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                icon: FontAwesomeIcons.user,
                                isDate: false,
                                obscure: false,
                                isEnabled: isEditable ? true : false,
                              ),
                              SizedBox(
                                height: 80,
                                child: DropdownMenu(
                                    textStyle: context.textTheme.bodyLarge!
                                        .copyWith(
                                            color: isEditable
                                                ? Colors.black
                                                : Colors.grey),
                                    initialSelection: "male",
                                    enabled: isEditable,
                                    width: MediaQuery.of(context).size.width,
                                    leadingIcon: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 32,
                                        right: 76,
                                      ),
                                      child: Icon(
                                        Icons.male,
                                        size: 32,
                                        color: AppColor.secondaryColor,
                                      ),
                                    ),
                                    inputDecorationTheme:
                                        const InputDecorationTheme(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                      color: Colors.grey,
                                    ))),
                                    dropdownMenuEntries: const [
                                      DropdownMenuEntry(
                                          value: "male", label: "Male"),
                                      DropdownMenuEntry(
                                          value: "female", label: "Female")
                                    ]),
                              ),
                              ProfileTextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email_outlined,
                                isDate: false,
                                obscure: false,
                                isEnabled: isEditable ? true : false,
                              ),
                              ProfileTextFormField(
                                controller: _dateController,
                                keyboardType: TextInputType.none,
                                icon: Icons.calendar_month_outlined,
                                isDate: true,
                                obscure: false,
                                isEnabled: isEditable ? true : false,
                              ),
                              ProfileTextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.number,
                                icon: Icons.phone_outlined,
                                isDate: false,
                                obscure: false,
                                isEnabled: isEditable ? true : false,
                              ),
                              ProfileTextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.number,
                                icon: Icons.lock_outline,
                                isDate: false,
                                obscure: true,
                                isEnabled: isEditable ? true : false,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Feedback.forTap(context);
                                  setState(() {
                                    isEditable = !isEditable;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 230,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Text(
                                    "Edit Profile",
                                    style: context.textTheme.headlineSmall!
                                        .copyWith(
                                      color: AppColor.textColorSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return null;
                },
                error: (e, stack) =>
                    throw Exception("error in .when in profilepage $e"),
                loading: () => const CircularProgressIndicator())
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<void> _getProfileData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final userDataAsync = ref.read(userDataProvider(user.uid)).valueOrNull;
    if (userDataAsync == null) return;
    final currentUser =
        AppUser.fromJson(userDataAsync.data() as Map<String, dynamic>);
    _nameController.text = currentUser.fullName;
    _emailController.text = currentUser.email;
    _phoneController.text = "12345678";
    _dateController.text = "2001-01-01";
    _passwordController.text = "1234567890";
    isLoading = false;
    return;
  }

  Future<void> cartToSneakerModels() async {}
}
