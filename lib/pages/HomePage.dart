import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_app/language/Language.dart';
import 'package:test_app/language/language_constants.dart';

import 'package:test_app/main.dart';
import 'package:test_app/log/LoginScreen.dart';
import 'package:test_app/style/StyleText.dart';

// HomePage is a StatefulWidget that initializes Firebase and displays the LoginScreen.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _key is a GlobalKey used for the FormState.
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // _initializeFirebase is an asynchronous function that initializes Firebase and returns a FirebaseApp.
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    // The Scaffold contains an AppBar with a DropdownButton for language selection and a FutureBuilder for Firebase initialization.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF006766),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              // The DropdownButton allows the user to select a language. When a language is selected, the locale is updated.
              child: DropdownButton<Language>(
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    MyApp.setLocale(context, _locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: StyleText.getBody(size: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ],
        ),
        // The FutureBuilder waits for Firebase to initialize. Once Firebase is initialized, the LoginScreen is displayed.
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginScreen();
            }
            // While waiting for Firebase to initialize, a CircularProgressIndicator is displayed.
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}