import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;


void signUp(String email, String password) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    debugPrint("Signup successful!");
  } catch (e) {
    debugPrint("Signup failed: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Name
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF2F8C99)),
              hintText: 'Name',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal, width: 2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF2F8C99)),
              hintText: 'Email Address',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal, width: 2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Password
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF2F8C99)),
              suffixIcon: const Icon(Icons.visibility_outlined, color: Color(0xFF2F8C99)),
              hintText: 'Password',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal, width: 2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Confirm Password
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF2F8C99)),
              suffixIcon: const Icon(Icons.visibility_outlined, color: Color(0xFF2F8C99)),
              hintText: 'Confirm Password',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.teal, width: 2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
onPressed: () async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  final confirmPassword = confirmPasswordController.text.trim();

  if (password != confirmPassword) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Passwords do not match")),
    );
    return;
  }

  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    debugPrint("Signup successful!");

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/main');
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Signup failed: $e")),
    );
  }
},

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004855),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Moved inside TextStyle
                ),
              ),

            ),
          ),

          const SizedBox(height: 20),

          // Divider with text
          Row(
            children: const [
              Expanded(child: Divider(thickness: 1, color: Colors.teal)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Or sign up with"),
              ),
              Expanded(child: Divider(thickness: 1, color: Colors.teal)),
            ],
          ),

          const SizedBox(height: 20),

          // Google Sign Up Button
          OutlinedButton.icon(
            onPressed: () {
              debugPrint("Signup with Google");
            },
              icon: Image.asset(
                'assets/icons/google.png',
                height: 24,
                width: 24,
              ),
            label: const Text(
              "Google",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white, // Button background set to white
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(color: Colors.black12),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }
}
