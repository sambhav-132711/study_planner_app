import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final profileBox =
      Hive.box("profileBox");

  final settingsBox =
      Hive.box("settingsBox");

  /// FIREBASE USER
  String name =
      FirebaseAuth.instance.currentUser
              ?.displayName ??

          FirebaseAuth.instance.currentUser
              ?.email ??

          "Student";

  String? imagePath;

  bool darkMode = false;

  String language = "en";

  @override
  void initState() {

    super.initState();

    /// IMAGE
    imagePath =
        profileBox.get("image");

    /// DARK MODE
    darkMode =
        settingsBox.get(

      "darkMode",

      defaultValue: false,
    );

    /// LANGUAGE
    language =
        settingsBox.get(

      "languageCode",

      defaultValue: "en",
    );
  }

  /// PICK IMAGE
  Future pickImage(
      ImageSource source) async {

    final picker =
        ImagePicker();

    final picked =
        await picker.pickImage(
      source: source,
    );

    if (picked != null) {

      setState(() {

        imagePath =
            picked.path;
      });

      profileBox.put(
          "image",
          imagePath);
    }
  }

  /// REMOVE IMAGE
  void removeImage() {

    setState(() {

      imagePath = null;
    });

    profileBox.delete(
        "image");
  }

  /// AVATAR OPTIONS
  void showAvatarOptions() {

    final lang =
        AppLocalizations.of(context);

    showModalBottomSheet(

      context: context,

      builder: (_) {

        return SafeArea(

          child: Column(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              ListTile(

                leading:
                    const Icon(
                        Icons.camera_alt),

                title: Text(

                  lang.translate(
                      'take_photo'),
                ),

                onTap: () {

                  Navigator.pop(
                      context);

                  pickImage(
                      ImageSource.camera);
                },
              ),

              ListTile(

                leading:
                    const Icon(
                        Icons.photo),

                title: Text(

                  lang.translate(
                      'choose_photo'),
                ),

                onTap: () {

                  Navigator.pop(
                      context);

                  pickImage(
                      ImageSource.gallery);
                },
              ),

              if (imagePath != null)

                ListTile(

                  leading:
                      const Icon(
                          Icons.delete),

                  title: Text(

                    lang.translate(
                        'remove_photo'),
                  ),

                  onTap: () {

                    Navigator.pop(
                        context);

                    removeImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  /// EDIT NAME
  Future editName() async {

    final lang =
        AppLocalizations.of(context);

    TextEditingController
        controller =
        TextEditingController(
            text: name);

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: Text(

            lang.translate(
                'edit_name'),
          ),

          content:
              TextField(

            controller:
                controller,

            decoration:
                InputDecoration(

              labelText:
                  lang.translate(
                      'enter_name'),
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                    context);
              },

              child: Text(

                lang.translate(
                    'cancel'),
              ),
            ),

            ElevatedButton(

              onPressed:
                  () async {

                final user =
                    FirebaseAuth.instance
                        .currentUser;

                await user
                    ?.updateDisplayName(
                        controller.text);

                setState(() {

                  name =
                      controller.text;
                });

                Navigator.pop(
                    context);
              },

              child: Text(

                lang.translate(
                    'save'),
              ),
            ),
          ],
        );
      },
    );
  }

  /// DARK MODE
  void toggleDarkMode(
      bool value) {

    setState(() {

      darkMode = value;
    });

    settingsBox.put(
        "darkMode",
        value);
  }

  /// LOGOUT
  Future logout() async {

    await FirebaseAuth.instance
        .signOut();

    await GoogleSignIn()
        .signOut();

    await GoogleSignIn()
        .disconnect();

    await profileBox.clear();
  }

  @override
  Widget build(
      BuildContext context) {

    bool isDark =
        Theme.of(context)
                .brightness ==

            Brightness.dark;

    final lang =
        AppLocalizations.of(
            context);

    return Scaffold(

      backgroundColor:
          isDark

              ? const Color(
                  0xff0E0B16)

              : Colors.white,

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            isDark

                ? const Color(
                    0xff0E0B16)

                : Colors.white,

        iconTheme:
            IconThemeData(

          color:
              isDark

                  ? Colors.white

                  : Colors.black,
        ),

        title: Text(

          "Profile",

          style: TextStyle(

            color:
                isDark

                    ? Colors.white

                    : Colors.black,
          ),
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
                20),

        child: ListView(

          children: [

            /// PROFILE IMAGE
            Center(

              child:
                  GestureDetector(

                onTap:
                    showAvatarOptions,

                child:
                    CircleAvatar(

                  radius: 45,

                  backgroundColor:
                      Colors.deepPurple,

                  backgroundImage:
                      imagePath != null

                          ? FileImage(
                              File(
                                  imagePath!))

                          : null,

                  child:
                      imagePath == null

                          ? Text(

                              name[0]
                                  .toUpperCase(),

                              style:
                                  const TextStyle(

                                fontSize:
                                    35,

                                color:
                                    Colors.white,
                              ),
                            )

                          : null,
                ),
              ),
            ),

            const SizedBox(
                height: 20),

            /// NAME
            Row(

              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              children: [

                Text(

                  "${lang.translate('hello')} : $name",

                  style: TextStyle(

                    fontSize: 20,

                    fontWeight:
                        FontWeight
                            .w500,

                    color:
                        isDark

                            ? Colors.white

                            : Colors.black,
                  ),
                ),

                const SizedBox(
                    width: 8),

                GestureDetector(

                  onTap:
                      editName,

                  child: const Icon(

                    Icons.edit,

                    size: 20,

                    color:
                        Colors.deepPurple,
                  ),
                ),
              ],
            ),

            const SizedBox(
                height: 40),

            /// SETTINGS TITLE
            Text(

              lang.translate(
                  'settings'),

              style: TextStyle(

                fontSize: 24,

                fontWeight:
                    FontWeight.bold,

                color:
                    isDark

                        ? Colors.white

                        : Colors.black,
              ),
            ),

            const SizedBox(
                height: 20),

            /// LANGUAGE
            DropdownButtonFormField(

              value: language,

              decoration:
                  InputDecoration(

                labelText:
                    lang.translate(
                        'select_language'),

                border:
                    const UnderlineInputBorder(),
              ),

              items: const [

                DropdownMenuItem(

                  value: "en",

                  child:
                      Text(
                          "English"),
                ),

                DropdownMenuItem(

                  value: "te",

                  child:
                      Text(
                          "Telugu"),
                ),

                DropdownMenuItem(

                  value: "hi",

                  child:
                      Text(
                          "Hindi"),
                ),

                DropdownMenuItem(

                  value: "ta",

                  child:
                      Text(
                          "Tamil"),
                ),

                DropdownMenuItem(

                  value: "kn",

                  child:
                      Text(
                          "Kannada"),
                ),

                DropdownMenuItem(

                  value: "sv",

                  child:
                      Text(
                          "Swedish"),
                ),
              ],

              onChanged:
                  (value) {

                setState(() {

                  language =
                      value!;
                });

                settingsBox.put(

                  "languageCode",

                  language,
                );
              },
            ),

            const SizedBox(
                height: 20),

            /// DARK MODE
            SwitchListTile(

              title: Text(

                lang.translate(
                    'dark_mode'),
              ),

              value:
                  darkMode,

              onChanged:
                  toggleDarkMode,
            ),

            const SizedBox(
                height: 30),

            /// LOGOUT
            ElevatedButton(

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    isDark

                        ? const Color(
                            0xff1B1633)

                        : const Color(
                            0xffEDEDED),

                foregroundColor:
                    Colors.deepPurple,

                minimumSize:
                    const Size(
                        double.infinity,
                        55),

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                          30),
                ),
              ),

              onPressed:
                  logout,

              child: Text(

                lang.translate(
                    'logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}