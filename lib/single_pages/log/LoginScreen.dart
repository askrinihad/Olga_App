import 'package:flutter/material.dart';
import 'package:test_app/bdd/bdd_function.dart';
import 'package:test_app/navbar/NavDrawerbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/navbar/drawer/DrawerSections.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:test_app/single_pages/log/LoginFunction.dart';
import 'package:test_app/BDD/hive_function.dart';

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
  bool _saveUser = false;
  HiveService hiveService = HiveService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeSaveUser();
    _loadUser();
  }

  Future<void> _initializeSaveUser() async {
    bool? isUserLogged = await hiveService.isUserLogged();
    setState(() {
      _saveUser = isUserLogged;
    });
  }

  void _loadUser() async {
    var user = await hiveService.getUser();
    if (user != null) {
      setState(() {
        _emailController.text = user.email;
        _passwordController.text = user.password ?? '';
      });
    }
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
                child: buildAeroport(aeroportValue, (value) {
                  setState(() {
                    aeroportValue = value;
                  });
                }),
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
                    borderSide: BorderSide(color: Color(0xFF006766)),
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
                    borderSide: BorderSide(color: Color(0xFF006766)),
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
              Row(
                children: <Widget>[
                  Text(
                    'Stay Connected',
                    style: TextStyle(color: Color(0xFF006766)),
                  ),
                  Checkbox(
                    value: _saveUser,
                    onChanged: (bool? value) {
                      setState(() {
                        _saveUser = value ?? false;
                      });
                    },
                    activeColor: Color(0xFF006766),
                  ),
                ],
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
                    bool hasInternet = await checkInternetConnection();
                    if (hasInternet) {
                      User? user = await loginUsingEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (user != null) {
                        if (_saveUser) {
                          await hiveService.saveUser(
                            id: int.tryParse(user.uid) ?? 0,
                            email: _emailController.text,
                            password:
                                _saveUser ? _passwordController.text : null,
                            airport: aeroportValue,
                            token: user.refreshToken ?? '',
                            tokenExpiryDate:
                                DateTime.now().add(Duration(hours: 1)),
                            isLogged: true,
                          );
                        } else {
                          await hiveService.saveUser(
                            id: int.tryParse(user.uid) ?? 0,
                            email: _emailController.text,
                            password: null,
                            airport: aeroportValue,
                            token: user.refreshToken ?? '',
                            tokenExpiryDate:
                                DateTime.now().add(Duration(hours: 1)),
                            isLogged: false,
                          );
                        }
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
                    } else {
                      var user = await hiveService.getUser();
                      if (user != null && user.password != null) {
                        if (user.email == _emailController.text &&
                            user.password == _passwordController.text) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => NavDrawerbar(
                                      email: _emailController.text,
                                      aeroport: aeroportValue,
                                      currentPage: DrawerSections.Accueil)));
                        } else {
                          setState(() {
                            _errorMessage = 'Email or password is incorrect';
                          });
                        }
                      } else {
                        setState(() {
                          if (_saveUser) {
                            _errorMessage =
                                'No internet connection. Please check your connection and try again.';
                          } else {
                            _errorMessage =
                                'No internet connection and user credentials not saved. Please check your connection and try again.';
                          }
                        });
                      }
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
