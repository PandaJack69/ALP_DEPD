import 'package:alp_depd/view/pages/eventpage.dart';
import 'package:alp_depd/view/pages/loginpage.dart';
import 'package:alp_depd/view/pages/profilepage.dart';
import 'package:alp_depd/view/pages/registerpage.dart';
import 'package:alp_depd/view/pages/registrationpage.dart';
import 'package:alp_depd/view/widgets/pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart'; // <--- Import Options
import 'package:provider/provider.dart';
import 'viewmodel/authviewmodel.dart';
import 'view/pages/homepage.dart'; 

// Make main async
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Event',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
         initialRoute: "/home",
        routes: {
          "/home": (context) => const HomePage(),
          "/event": (context) => const EventPage(),
          // "/competition": (context) => const CompetitionPage(),
          // "/pengmas": (context) => const PengMasPage(),
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/profile": (context) => const ProfilePage(),
        },
      ),
    );
  }
}