import 'package:alp_depd/view/pages/registrationpage.dart';
import 'package:alp_depd/view/widgets/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import your view model and pages
import 'viewmodel/authviewmodel.dart';
import 'view/pages/homepage.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the MaterialApp with MultiProvider
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
        home: const HomePage(),
      ),
    );
  }
}