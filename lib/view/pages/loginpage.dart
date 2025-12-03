import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../../viewmodel/authviewmodel.dart'; // Import ViewModel

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                const Expanded(flex: 5, child: LeftSideHero()),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SignInForm(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.0),
                child: SignInForm(),
              ),
            );
          }
        },
      ),
    );
  }
}

// LeftSideHero remains exactly the same...
class LeftSideHero extends StatelessWidget {
  const LeftSideHero({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF360C4C)],
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Find Your Next\nExperience",
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Georgia')),
            SizedBox(height: 24),
            Text("Discover\n&\nPromote\nUpcoming\nEvents",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    fontFamily: 'Arial')),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// THE UPDATED FORM WITH LOGIC
// ---------------------------------------------------------------------------
class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  // Controllers to capture text input
  final TextEditingController _emailController = TextEditingController(text: "jonas_kahnwald@gmail.com");
  final TextEditingController _passwordController = TextEditingController();
  
  bool _keepLogged = false;
  bool _obscurePassword = true;
  
  // Toggle between Login and Register mode
  bool _isLoginMode = true; 

  @override
  Widget build(BuildContext context) {
    // Access the ViewModel
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _isLoginMode ? "Sign in" : "Create Account",
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          _isLoginMode 
            ? "Please login to continue to your account."
            : "Enter your details to get started.",
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 40),

        // Show Error Message if exists
        if (authViewModel.errorMessage != null)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
            child: Text(authViewModel.errorMessage!, style: const TextStyle(color: Colors.red)),
          ),

        // Email Field
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: const TextStyle(color: Color(0xFF4A0E60)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4A0E60), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Password Field
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Checkbox
        if (_isLoginMode)
          Row(
            children: [
              SizedBox(
                height: 24, width: 24,
                child: Checkbox(
                  value: _keepLogged,
                  activeColor: const Color(0xFF4A0E60),
                  onChanged: (val) => setState(() => _keepLogged = val!),
                ),
              ),
              const SizedBox(width: 8),
              const Text("Keep me logged in", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
        const SizedBox(height: 30),

        // ACTION BUTTON (Login / Register)
        ElevatedButton(
          onPressed: authViewModel.isLoading
              ? null
              : () async {
                  bool success;
                  if (_isLoginMode) {
                    success = await authViewModel.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                  } else {
                    success = await authViewModel.register(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }

                  if (success && mounted) {
                    // Navigate back to HomePage or Show success
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(_isLoginMode ? "Login Successful!" : "Account Created!")),
                    );
                    Navigator.pop(context); // Go back to Home
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF330C48),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: authViewModel.isLoading
              ? const SizedBox(
                  height: 20, width: 20, 
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : Text(_isLoginMode ? "Sign in" : "Register", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        
        const SizedBox(height: 40),

        // Footer Link (Toggle Mode)
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isLoginMode ? "Need an account? " : "Already have an account? ", style: const TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLoginMode = !_isLoginMode;
                    // Clear errors when switching
                    // Note: In a real app, you might want a method in ViewModel to clear error
                  });
                },
                child: Text(
                  _isLoginMode ? "Create one" : "Sign in",
                  style: const TextStyle(
                    color: Color(0xFF4A0E60),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}