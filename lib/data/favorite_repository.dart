// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FavoriteRepository {
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;

//   Future<Map<String, dynamic>> getFavorites() async {
//     final User? currentUser = _auth.currentUser;
//     if (currentUser != null) {
//       final userId = currentUser.uid;
//       final userDoc = await _firestore.collection("Users").doc(userId).get();
//       if (userDoc.exists) {
//         final data = userDoc.data();
//       }
//     }
//   }
// }
