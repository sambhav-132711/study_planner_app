import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import 'main_navigation_screen.dart';

class AuthGate extends StatelessWidget {

  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      stream:
          FirebaseAuth.instance
              .authStateChanges(),

      builder: (context, snapshot) {

        /// LOADING
        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(

            body: Center(

              child:
                  CircularProgressIndicator(),
            ),
          );
        }

        /// USER LOGGED IN
        if (snapshot.hasData) {

          return const MainNavigationScreen();
        }

        /// USER NOT LOGGED IN
        return const LoginScreen();
      },
    );
  }
}