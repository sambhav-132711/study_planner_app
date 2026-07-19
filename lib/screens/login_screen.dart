import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;

  bool loading = false;


  /// EMAIL LOGIN
  Future login() async {

    try {

      setState(() {

        loading = true;
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email:
            emailController.text.trim(),

        password:
            passwordController.text.trim(),
      );

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:
              Text(
                  e.message ??
                  "Login Failed"),
        ),
      );

    } finally {

      setState(() {

        loading = false;
      });
    }
  }


  /// GOOGLE LOGIN
  Future googleLogin() async {

    try {

      /// FORCE ACCOUNT CHOOSER
      await GoogleSignIn()
          .signOut();

      final GoogleSignInAccount?
          googleUser =
          await GoogleSignIn()
              .signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication
          googleAuth =
          await googleUser.authentication;

      final credential =
          GoogleAuthProvider.credential(

        accessToken:
            googleAuth.accessToken,

        idToken:
            googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(
              credential);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                  "Google Sign-In Failed"),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xff0F1E35),

      body: Center(

        child: SingleChildScrollView(

          child: Container(

            width: 350,

            padding:
                const EdgeInsets.all(25),

            decoration: BoxDecoration(

              color:
                  const Color(0xff132743),

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Column(

              children: [

                const Text(

                  "Login",

                  style: TextStyle(

                    fontSize: 28,

                    color: Colors.white,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                TextField(

                  controller:
                      emailController,

                  style:
                      const TextStyle(
                          color:
                              Colors.white),

                  decoration:
                      inputDecoration(
                          "Enter Email"),
                ),

                const SizedBox(height: 15),

                TextField(

                  controller:
                      passwordController,

                  obscureText:
                      obscurePassword,

                  style:
                      const TextStyle(
                          color:
                              Colors.white),

                  decoration:
                      inputDecoration(
                        "Enter Password",
                      ).copyWith(

                        suffixIcon:
                            IconButton(

                          icon: Icon(

                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,

                            color:
                                Colors.white70,
                          ),

                          onPressed: () {

                            setState(() {

                              obscurePassword =
                                  !obscurePassword;
                            });
                          },
                        ),
                      ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(

                  style:
                      buttonStyle(),

                  onPressed:
                      loading
                          ? null
                          : login,

                  child:
                      loading

                          ? const CircularProgressIndicator()

                          : const Text(
                              "Login"),
                ),

                const SizedBox(height: 15),

                const Text(

                  "OR",

                  style:
                      TextStyle(
                          color:
                              Colors.white70),
                ),

                const SizedBox(height: 15),

                ElevatedButton(

                  style:
                      googleButtonStyle(),

                  onPressed:
                      googleLogin,

                  child: Row(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Image.asset(

                        "assets/images/google_logo.png",

                        height: 22,
                      ),

                      const SizedBox(width: 10),

                      const Text(
                          "Sign in with Google"),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Text(

                      "Don't have account?",

                      style:
                          TextStyle(
                              color:
                                  Colors.white70),
                    ),

                    TextButton(

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>
                                const RegisterScreen(),
                          ),
                        );
                      },

                      child:
                          const Text(
                              "Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



InputDecoration inputDecoration(
    String hint) {

  return InputDecoration(

    filled: true,

    fillColor:
        const Color(0xff2E4A68),

    hintText: hint,

    hintStyle:
        const TextStyle(
            color: Colors.white70),

    border:
        OutlineInputBorder(

      borderRadius:
          BorderRadius.circular(8),

      borderSide:
          BorderSide.none,
    ),
  );
}



ButtonStyle buttonStyle() {

  return ElevatedButton.styleFrom(

    minimumSize:
        const Size(
            double.infinity,
            45),

    backgroundColor:
        Colors.lightBlueAccent,
  );
}



ButtonStyle googleButtonStyle() {

  return ElevatedButton.styleFrom(

    minimumSize:
        const Size(
            double.infinity,
            45),

    backgroundColor:
        Colors.white,

    foregroundColor:
        Colors.black,
  );
}