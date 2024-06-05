import 'package:flutter/material.dart';
import 'package:test_app/bdd/bdd_function.dart';
import 'package:test_app/navbar/NavDrawerbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
import 'package:test_app/style/StyleText.dart';

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
  String _errorMessage = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String aeroportValue = aeroportList.first;

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
      style: StyleText.getHintForm(), // Set the text color
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
                height: MediaQuery.of(context).size.height * 0.06,
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
                   Text(
                appLocalizations.motdepasseOublie,
                style: TextStyle(color:  Color(0xff8E7F7F))),
              
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.08,
              ),

              // Button for the login
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: Color(0xFF006766),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    elevation: 0.0,
                  ),
                  onPressed: () async {
                    print('in on press');
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                    print(user);

                    // If the user is not null, navigate to the AccueilPage
                    if (user != null) {
                      print('Navigating to AccueilPage');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NavDrawerbar(
                              email: _emailController.text,
                              aeroport: aeroportValue,
                              currentPage: DrawerSections.Accueil)));
                    }
                    else {
                      setState(() {
                        _errorMessage = 'Email or password is incorrect';
                      });
                    }
                  },
                  child: Text(appLocalizations.connexion,
                      style: StyleText.getButton()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
