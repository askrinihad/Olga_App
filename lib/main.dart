import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Accueil.dart';
import 'package:test_app/Bibliotheque.dart';
import 'package:test_app/Historique.dart';
import 'package:test_app/profile_screen.dart';
import 'package:test_app/mymap_page.dart';
import 'package:test_app/language.dart';
import 'package:test_app/language_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
   @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale:_locale,
      home: HomePage(),
      //home: ProfileScreen(),
      //home: MapApp(),
    
       
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

     Future<FirebaseApp> _initializeFirebase() async{
       FirebaseApp firebaseApp = await Firebase.initializeApp();
       return firebaseApp;
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xFF006766),
        
       actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                            style: const TextStyle(fontSize: 30),
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
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      

    body: SingleChildScrollView(
      child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
             Center(
      child: Image.asset(
        'assets/olga.jpg', // Replace with the actual path to your image
        width: 242.0, // Set the desired width
        height: 242.0, // Set the desired height
      ),
    ), // Adjust the path based on your project structure
      SizedBox(
        height: 20.0,
      ),
      TextField(
        controller:_emailController,
        keyboardType: TextInputType.emailAddress,
        decoration:  InputDecoration(
          hintText: appLocalizations.email,
          prefixIcon: Icon(Icons.mail, color: Color(0xFF006766),),
          focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF006766)), // Set the border color when focused
    ),
        ),
      ),
      SizedBox(
        height: 26.0,
      ),
      TextField(
        controller:_passwordController,
        obscureText: true,
        decoration:  InputDecoration(
          hintText: appLocalizations.motdepasse,
          prefixIcon: Icon(Icons.lock, color: Color(0xFF006766),),
              focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF006766)), // Set the border color when focused
    ),
        ),
      ),
       SizedBox(
        height: 16.0,
      ),
      Text(
            appLocalizations.motdepasseOublie,
            style: TextStyle(color:  Color(0xff8E7F7F))),
      SizedBox(
        height: 88.0,
      ),
      Container(
        width: double.infinity,
        child: RawMaterialButton(
          fillColor: const  Color(0xFF006766),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen(email:_emailController.text)));
            }
          },
          child: Text(appLocalizations.connexion, style: TextStyle(color: Colors.white,
          fontSize: 13.0
          )),
          ),
      ),
      ],
    ),
    ),),
     );
  }
}
  