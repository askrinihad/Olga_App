import 'package:flutter/material.dart';
import 'package:test_app/menu/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

const List<String> aeroportList = <String>[
  'Paris-Charles de Gaulle Airport',
  'Zagreb Airport ',
  'Milan Airport',
  'Avram Iancu Cluj Airport'
];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// Allows the user to log in using their email and password
/// User can choose an airport from a predefined list
/// User can also reset their password
class _LoginScreenState extends State<LoginScreen> {
  // Create a controller for each text field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String aeroportValue = aeroportList.first;

  /// Create a function to log in using email and password
  /// Take the email and password as parameters
  static Future<User?> loginUsingEmailPassword({required String email,
    required String password,
    required BuildContext context}) async {
    // Create an instance of FirebaseAuth
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try { // Try to sign in using the email and password
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print(" no user found for that email");
      }
    }
    return user;
  }

  ///////////////////////////////////////////
  /// Widget to build the dropdown button for Aeroport List selection
  Widget _buildAeroport() {
    return DropdownButton<String>(
      value: aeroportValue,
      isExpanded: false,
      underline: Container(
        height: 0, // Set the height to 0 to hide the underline
        color: Colors.transparent, // Set the underline color to transparent
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: 103.0), // Adjust the right padding
        child: Icon(Icons.arrow_drop_down), // Add the icon
      ),
      elevation: 16,
      style: const TextStyle(color: Colors.grey), // Set the text color
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          aeroportValue = value!;
        });
      },
      // Create a list of DropdownMenuItem widgets
      items: aeroportList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0), // Adjust the left padding
            child: Text(value), // Set the text value
          ),
        );
      }).toList(),
    );
  }

/////////////////////////////////////////////////
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

/////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.06,
              ),

              // Image Olga
              Center(
                child: Image.asset(
                  'assets/olga.jpg',
                  // Replace with the actual path to your image
                  width: 242.0, // Set the desired width
                  height: 242.0, // Set the desired height
                ),
              ), // Adjust the path based on your project structure
              SizedBox(
                height: 20.0,
              ),

              // Text for the title
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(
                          0xFF006766), // Set the border color when focused
                    ),
                  ),
                ),
                child: _buildAeroport(),
              ),
              const SizedBox(height: 26),

              // TextField for enter email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: appLocalizations.email,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Color(0xFF006766), // couleur de l'icône
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF006766)), // Set the border color when focused
                  ),
                ),
              ),
              SizedBox(
                height: 26.0,
              ),

              // TextField for enter password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.motdepasse,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF006766),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF006766)), // Set the border color when focused
                  ),
                ),
              ),
              
              // Text for the password reset
              SizedBox(
                height: 16.0,
              ),
              Text(appLocalizations.motdepasseOublie,
                  style: TextStyle(color: Color(0xff8E7F7F))),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .width * 0.1,
              ),

              // Button for the login
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFF006766),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  onPressed: () async {
                    print('in on press');
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);
                    print(user);

                    // If the user is not null, navigate to the AccueilPage
                    if (user != null) {
                      print('Navigating to AccueilPage');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(
                                  email: _emailController.text,
                                  aeroport: aeroportValue)));
                    }
                  },

                  child: Text(appLocalizations.connexion,
                      style: TextStyle(color: Colors.white, fontSize: 13.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}