// File: lib/view/pages/loginpage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/database_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DatabaseProvider>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("The Event Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              
              TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder())),
              const SizedBox(height: 15),
              TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder())),
              
              const SizedBox(height: 30),
              
              if (provider.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () async {
                    String? error = await provider.login(_emailCtrl.text, _passCtrl.text);
                    
                    if (error == null) {
                       // Login Sukses, AuthCheckWrapper di main.dart akan handle pindah halaman
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: Colors.red));
                    }
                  },
                  child: const Text("Sign In"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}