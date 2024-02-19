import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Accueil.dart';
import 'package:test_app/Bibliotheque.dart';
import 'package:test_app/Historique.dart';
import 'package:test_app/profile_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      home: ProfileScreen(),
       
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

     Future<FirebaseApp> _initializeFirebase() async{
       FirebaseApp firebaseApp = await Firebase.initializeApp();
       return firebaseApp;
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },)
      );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
       //create the textfield controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   static Future<User?> loginUsingEmailPassword(
    {required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth= FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user=userCredential.user;
    } on FirebaseAuthException catch(e){
       if(e.code == "user-not-found"){
         print(" no user found for that email");

       }
    }
    return user;
   }
  @override
  void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
             Center(
      child: Image.asset(
        'assets/adp_logo.png', // Replace with the actual path to your image
        width: 242.0, // Set the desired width
        height: 135.0, // Set the desired height
      ),
    ), // Adjust the path based on your project structure
      SizedBox(
        height: 44.0,
      ),
      TextField(
        controller:_emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.mail, color: Color(0xff121F98),)
        ),
      ),
      SizedBox(
        height: 26.0,
      ),
      TextField(
        controller:_passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Mot de passe",
          prefixIcon: Icon(Icons.lock, color: Color(0xff121F98),)
        ),
      ),
       SizedBox(
        height: 16.0,
      ),
      Text(
            'Mot de passe oublié?',
            style: TextStyle(color:  Color(0xff8E7F7F))),
      SizedBox(
        height: 88.0,
      ),
      Container(
        width: double.infinity,
        child: RawMaterialButton(
          fillColor: const  Color(0xff121F98),
          elevation: 0.0,
          padding: const  EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)),
          onPressed: () async{
            print('in on press');
            User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
            print(user);
            
            if(user != null)
            { 
              print('Navigating to AccueilPage');
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
            }
          },
          child: const Text("Connexion", style: TextStyle(color: Colors.white,
          fontSize: 13.0
          )),
          ),
      ),
      ],
    ),
    ), );
  }
}
  