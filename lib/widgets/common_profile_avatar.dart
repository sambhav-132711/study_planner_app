import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/profile_screen.dart';

class CommonProfileAvatar extends StatelessWidget {

  const CommonProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {

    final profileBox =
        Hive.box("profileBox");

    String? imagePath =
        profileBox.get("image");

    final user =
        FirebaseAuth.instance.currentUser;

    String name =
        user?.displayName ??
        user?.email ??
        "Student";

    String firstLetter =
        name[0].toUpperCase();

    return Padding(

      padding:
          const EdgeInsets.only(
              right: 15),

      child: GestureDetector(

        onTap: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const ProfileScreen(),
            ),
          );
        },

        child: CircleAvatar(

          radius: 18,

          backgroundColor:
              Colors.deepPurple,

          backgroundImage:
              imagePath != null

                  ? FileImage(
                      File(imagePath),
                    )

                  : null,

          child:
              imagePath == null

                  ? Text(

                      firstLetter,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    )

                  : null,
        ),
      ),
    );
  }
}