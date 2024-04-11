import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneakers_shop_app/pages/for_storing_data.dart';
import 'package:sneakers_shop_app/pages/location_test.dart';
import 'package:sneakers_shop_app/pages/start_page.dart';
import 'package:sneakers_shop_app/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sneaker Shop App',
      theme: ThemeData(
        fontFamily: GoogleFonts.varelaRound().fontFamily,
        useMaterial3: true,
      ),
      home:
          //  const ForStroingData(),
          StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else if (snapshot.hasError) {
                  throw Exception("error in steamBuilder");
                }
                return const StartPage();
              }),
    );
  }
}
