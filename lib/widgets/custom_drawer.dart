import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/data/auth_repositroy.dart';
import 'package:sneakers_shop_app/models/app_user.dart';
import 'package:sneakers_shop_app/pages/favorites_page.dart';
import 'package:sneakers_shop_app/pages/profile_page.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';

final userDataProvider =
    StreamProvider.family<DocumentSnapshot, String>((ref, userId) {
  return FirebaseFirestore.instance.collection('Users').doc(userId).snapshots();
});

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(userDataProvider(FirebaseAuth.instance.currentUser!.uid));

    return userData.when(data: (userSnapshot) {
      final userData = userSnapshot.data();
      if (userData != null) {
        final currentUser = AppUser.fromJson(userData as Map<String, dynamic>);

        return Drawer(
          width: 320,
          elevation: 0,
          backgroundColor: AppColor.backgroundColor,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  currentUser.fullName,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  currentUser.email,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColor.textColor.withOpacity(0.5),
                  ),
                ),
                currentAccountPicture: Stack(
                  children: [
                    CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColor.cardBackgroundColor,
                        foregroundImage: currentUser.image.isNotEmpty
                            ? MemoryImage(base64Decode(currentUser.image))
                            : null),
                  ],
                ),
                currentAccountPictureSize: const Size(60, 60),
                decoration:
                    const BoxDecoration(color: AppColor.backgroundColor),
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.solidUser,
                ),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: const ProfilePage(),
                      type: PageTransitionType.leftToRightWithFade,
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500)));
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.solidStar,
                ),
                title: const Text("Favorites"),
                onTap: () {
                  Navigator.of(context).push(PageTransition(
                      child: const FavortiesPage(),
                      type: PageTransitionType.leftToRightWithFade,
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500)));
                },
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.receipt),
                title: const Text("Orders"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.gear),
                title: const Text("Settings"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(FontAwesomeIcons.arrowRightFromBracket,
                    color: AppColor.errorColor),
                title: const Text("Log Out"),
                titleTextStyle: context.textTheme.bodyLarge!.copyWith(
                  color: AppColor.errorColor,
                ),
                onTap: () {
                  ref.read(authRepositroyProvider).signOutUser();
                },
              ),
            ],
          ),
        );
      } else {
        throw Exception("error in .when drawer in else");
      }
    }, error: (e, stack) {
      throw Exception("error in .when drawer $e");
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
