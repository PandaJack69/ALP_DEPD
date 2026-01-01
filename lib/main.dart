// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Import Pages & Provider
import 'viewmodel/database_provider.dart';
import 'view/pages/loginpage.dart';
import 'view/pages/admin/admindashboard.dart';
import 'view/pages/admin/organizerdashboard.dart';
import 'view/pages/user/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load .env
  await dotenv.load(fileName: ".env");

  // Init Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider()..loadUser()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Event',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const AuthCheckWrapper(), // Wrapper pintar untuk cek login
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/admin': (context) => const AdminDashboard(),
          '/organizer': (context) => const OrganizerDashboard(),
        },
      ),
    );
  }
}

// Widget Pintar: Cek status login & Role lalu arahkan otomatis
class AuthCheckWrapper extends StatelessWidget {
  const AuthCheckWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DatabaseProvider>();

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!provider.isLoggedIn) {
      return const LoginPage();
    }

    // Role Based Routing
    final role = provider.currentUser?.role;
    if (role == 'admin') return const AdminDashboard();
    if (role == 'organizer') return const OrganizerDashboard();
    
    return const HomePage();
  }
}