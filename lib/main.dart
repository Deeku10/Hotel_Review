import 'package:flutter/material.dart';
import 'package:hotel_management/Screens/home.dart';
import 'package:hotel_management/Screens/login.dart';
import 'package:hotel_management/models/google_signin.dart';
import 'package:hotel_management/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: HotelAppTheme().hotelAppTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          GoogleLogin.id: (context) => const GoogleLogin(),
          HomePage.id: (context) => const HomePage(),
          // HotelPage.id: (context) => const HotelPage()
        },
        initialRoute: GoogleLogin.id,
      ),
    );
  }
}
