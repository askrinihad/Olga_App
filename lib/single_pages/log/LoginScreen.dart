import 'package:flutter/material.dart';
import 'package:test_app/bdd/bdd_function.dart';
import 'package:test_app/navbar/NavDrawerbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


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

class _LoginScreenState extends State<LoginScreen> {
  String _errorMessage = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String aeroportValue = aeroportList.first;

  Widget _buildAeroport() {
    return DropdownButton<String>(
      value: aeroportValue,
      isExpanded: false,
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
      icon: Padding(
        padding: EdgeInsets.only(left: 103.0),
        child: Icon(Icons.arrow_drop_down),
      ),
      elevation: 16,
      style: StyleText.getHintForm(),
      onChanged: (String? value) {
        setState(() {
          aeroportValue = value!;
        });
      },
      items: aeroportList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(value),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

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
              Center(
                child: Image.asset(
                  'assets/olga.jpg',
                  width: 242.0,
                  height: 242.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF006766),
                    ),
                  ),
                ),
                child: _buildAeroport(),
              ),
              const SizedBox(height: 26),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: appLocalizations.email,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Color(0xFF006766),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF006766)),
                  ),
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
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
                        color: Color(0xFF006766)),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                appLocalizations.motdepasseOublie,
                style: TextStyle(color: Color(0xff8E7F7F)),
              ),
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
                    bool hasInternet = await _checkInternetConnection();
                    if (!hasInternet) {
                      setState(() {
                        _errorMessage = 'No internet connection. Please check your connection and try again.';
                      });
                      return;
                    }
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NavDrawerbar(
                              email: _emailController.text,
                              aeroport: aeroportValue,
                              currentPage: DrawerSections.Accueil)));
                    } else {
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
