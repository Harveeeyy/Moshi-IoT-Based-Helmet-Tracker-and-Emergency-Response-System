import 'package:flutter/material.dart';
import 'signup.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // From FlutterFire CLI
import 'main.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseAuth.instance.currentUser == null
        ? const AuthPage()
        : const MyHelmetPage(), // <-- Replace with your main screen widget
  ));
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FC),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "MOSHI",
                style: TextStyle(
                  fontFamily: 'LeagueSpartan',
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),

              // Container with background image and tab logic
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      // Background image
                      Positioned.fill(
                        child: Opacity(
                          opacity: 1.0,
                          child: Image.asset(
                            'assets/images/bg2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      // Foreground content
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            // TabBar
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF2F8C99).withAlpha(50),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.teal, width: 2),
                              ),
                              child: TabBar(
                                indicatorColor: Colors.transparent,
                                indicator: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.teal,
                                labelPadding: EdgeInsets.zero,
                                tabs: const [
                                  Tab(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                                      child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Tab(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                                      child: Text("Signup", style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // TabBarView inside Expanded to take remaining space
                            Expanded(
                              child: TabBarView(
                                children: [
                                  LoginTab(),
                                  SignupTab(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;


  void login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      debugPrint("Login successful!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHelmetPage()),
      );
    } catch (e) {
      debugPrint("Login failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }




  @override
  void initState() {
    super.initState();
    loadRememberMe(); // load saved preference on startup
  }

  // Save checkbox value
  void saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);
  }

  // Load checkbox value
  void loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('remember_me') ?? false;
    setState(() {
      rememberMe = value;
    });
  }




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email_outlined,
                  color: Color(0xFF2F8C99)),
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
              prefixIcon: const Icon(Icons.lock_outline,
                  color: Color(0xFF2F8C99)),
              suffixIcon: const Icon(Icons.visibility_outlined,
                  color: Color(0xFF2F8C99)),
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

          const SizedBox(height: 10),

          // Remember Me
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: (val) {
                  setState(() {
                    rememberMe = val!;
                    saveRememberMe(rememberMe);
                  });
                },
                activeColor: Colors.teal,
              ),
              const Text(
                "Remember me",
              style: TextStyle(color: Colors.teal),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Login Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                  login(emailController.text.trim(), passwordController.text.trim());
                },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004855),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18,
               color: Colors.white,
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
                child: Text("Or login with"),
              ),
              Expanded(child: Divider(thickness: 1, color: Colors.teal)),
            ],
          ),

          const SizedBox(height: 20),

          // Google Login Button
          OutlinedButton.icon(
  onPressed: () {
    debugPrint("Login with Google");
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
    backgroundColor: Colors.white, 
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

