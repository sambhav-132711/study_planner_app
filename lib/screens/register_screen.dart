import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen
    extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final nameController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmController =
      TextEditingController();

  bool obscurePassword = true;

  bool obscureConfirm = true;

  bool loading = false;


  /// REGISTER
  Future register() async {

    if (passwordController.text !=
        confirmController.text) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text(
                  "Passwords do not match"),
        ),
      );

      return;
    }

    try {

      setState(() {

        loading = true;
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(

        email:
            emailController.text.trim(),

        password:
            passwordController.text.trim(),
      );

      /// UPDATE FIREBASE NAME
      final user =
          FirebaseAuth.instance.currentUser;

      await user?.updateDisplayName(
          nameController.text);

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:
              Text(
                  e.message ??
                  "Register Failed"),
        ),
      );

    } finally {

      setState(() {

        loading = false;
      });
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

                  "Register",

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
                      nameController,

                  style:
                      const TextStyle(
                          color:
                              Colors.white),

                  decoration:
                      inputDecoration(
                          "Full Name"),
                ),

                const SizedBox(height: 15),

                TextField(

                  controller:
                      phoneController,

                  keyboardType:
                      TextInputType.phone,

                  style:
                      const TextStyle(
                          color:
                              Colors.white),

                  decoration:
                      inputDecoration(
                          "Phone Number"),
                ),

                const SizedBox(height: 15),

                TextField(

                  controller:
                      emailController,

                  style:
                      const TextStyle(
                          color:
                              Colors.white),

                  decoration:
                      inputDecoration(
                          "Email"),
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
                        "Password",
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

                const SizedBox(height: 15),

                TextField(

                  controller:
                      confirmController,

                  obscureText:
                      obscureConfirm,

                  style:
                      const TextStyle(
                          color:
                              Colors.white),

                  decoration:
                      inputDecoration(
                        "Confirm Password",
                      ).copyWith(

                        suffixIcon:
                            IconButton(

                          icon: Icon(

                            obscureConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,

                            color:
                                Colors.white70,
                          ),

                          onPressed: () {

                            setState(() {

                              obscureConfirm =
                                  !obscureConfirm;
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
                          : register,

                  child:
                      loading

                          ? const CircularProgressIndicator()

                          : const Text(
                              "Register"),
                ),

                const SizedBox(height: 15),

                TextButton(

                  onPressed: () {

                    Navigator.pop(context);
                  },

                  child:
                      const Text(
                          "Back to Login"),
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