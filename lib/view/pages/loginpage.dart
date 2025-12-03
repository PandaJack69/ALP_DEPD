import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We use LayoutBuilder to determine if we are on a desktop/web (wide)
    // or mobile (narrow) screen.
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Desktop/Tablet View (Split Screen)
            return Row(
              children: [
                const Expanded(
                  flex: 5,
                  child: LeftSideHero(),
                ),
                Expanded(
                  flex: 6, // Slightly wider for the form area
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
            // Mobile View (Form Only)
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

// ---------------------------------------------------------------------------
// 1️⃣ The Left Side (Updated Gradient & Text)
// ---------------------------------------------------------------------------
class LeftSideHero extends StatelessWidget {
  const LeftSideHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // The specific dark navy -> deep purple gradient
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A), // Very Dark Navy (Top Left)
            Color(0xFF360C4C), // Deep Rich Purple (Bottom Right)
          ],
        ),
        // The rounded corners on the right side
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Find Your Next\nExperience",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontFamily: 'Georgia', 
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Discover\n&\nPromote\nUpcoming\nEvents",
              style: TextStyle(
                color: Colors.white,
                fontSize: 52,
                fontWeight: FontWeight.w900, // Extra Bold
                height: 1.1, // Tighter line spacing
                fontFamily: 'Arial',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2️⃣ The Right Side (The Form)
// ---------------------------------------------------------------------------
class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _keepLogged = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        const Text(
          "Sign in",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Please login to continue to your account.",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 40),

        // Email Field
        TextFormField(
          initialValue: "jonas_kahnwald@gmail.com",
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: const TextStyle(color: Color(0xFF4A0E60)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4A0E60), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF4A0E60), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 20),

        // Password Field
        TextFormField(
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
        const SizedBox(height: 15),

        // Checkbox
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _keepLogged,
                activeColor: const Color(0xFF4A0E60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (val) {
                  setState(() {
                    _keepLogged = val!;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "Keep me logged in",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Sign In Button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF330C48), // Dark Purple
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
          child: const Text(
            "Sign in",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),

        // "or" Divider
        Row(
          children: const [
            Expanded(child: Divider(color: Colors.grey)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("or", style: TextStyle(color: Colors.grey)),
            ),
            Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 20),

        // Google Button
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: const BorderSide(color: Colors.black12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Arial'),
                  children: [
                    TextSpan(text: "G", style: TextStyle(color: Colors.blue)),
                    TextSpan(text: "o", style: TextStyle(color: Colors.red)),
                    TextSpan(text: "o", style: TextStyle(color: Colors.amber)),
                    TextSpan(text: "g", style: TextStyle(color: Colors.blue)),
                    TextSpan(text: "l", style: TextStyle(color: Colors.green)),
                    TextSpan(text: "e", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Sign in with Google",
                style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        // Footer Link
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Need an account? ", style: TextStyle(color: Colors.grey)),
              Text(
                "Create one",
                style: TextStyle(
                  color: Color(0xFF4A0E60),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}