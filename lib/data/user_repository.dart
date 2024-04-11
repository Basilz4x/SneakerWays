import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sneakers_shop_app/models/app_user.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> addUser({required AppUser user}) async {
    final userJson = user.toJson();
    await _fireStore.collection("Users").doc(user.uid).set(userJson);
  }

  Future<AppUser?> getUserData(String uid) async {
    if (_auth.currentUser != null) {
      final userDoc = await _fireStore.collection("Users").doc(uid).get();
      if (userDoc.exists) {
        final user = AppUser.fromJson(userDoc.data()!);
        return user;
      }
    }
    return null;
  }

  Future<void> updateUserImage() async {
    if (_auth.currentUser != null) {
      try {
        final uid = _auth.currentUser!.uid;
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageFile = File(image.path);
        final List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        final userData = await getUserData(uid);

        if (userData != null) {
          AppUser userDataWithNewImage = userData.copyWith(image: base64Image);
          await _fireStore
              .collection("Users")
              .doc(uid)
              .update({"image": userDataWithNewImage.image});
        }
      } catch (e) {
        throw Exception("error in updateUserImage :$e");
      }
    }
  }
}

final userRepositoryProvider = Provider((ref) => UserRepository());
