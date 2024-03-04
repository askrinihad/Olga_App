import 'package:flutter/material.dart';
import 'package:test_app/Accueil.dart';
import 'package:test_app/Bibliotheque.dart';
import 'package:test_app/Historique.dart';
import 'package:test_app/ajouterEspece.dart';
import 'package:test_app/choixEspece.dart';
import 'package:test_app/main.dart';
import 'package:test_app/mydrawer_header.dart';
import 'package:test_app/NouvelleObservation.dart';

class Espece extends StatefulWidget {
  final String argumentReceived;

  const Espece({required this.argumentReceived, super.key});
  //const Espece({super.key});

  @override
  State<Espece> createState() => _EspeceState();
}

class _EspeceState extends State<Espece> {
  var currentPage  = DrawerSections.Espece;
  @override
  Widget build(BuildContext context) {
     var container;
    //print("Received Argument: ${widget.argumentReceived}");
    container = ChoixEspece(argumentReceived: widget.argumentReceived);
    
    
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff586CB2),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(child: Container(
          child: Column(children: [
            MyheaderDrawer(),
            MyDrawerList(),
          ]),
        )),
      ),
    );
  }
Widget MyDrawerList(){
  return Container(
    padding: EdgeInsets.only(top:15,),
    child: Column(
      children: [
        menuItem(1, "Accueil", Icons.home, currentPage == DrawerSections.Accueil ? true: false),
        menuItem(2, "Nouvelle observation", Icons.add_box_rounded, currentPage == DrawerSections.NouvelleObservation ? true: false),
        menuItem(3, "Nouvelle espèce", Icons.add_box_rounded, currentPage == DrawerSections.NouvelleEspece ? true: false),
        menuItem(4, "Historique des observations", Icons.history, currentPage == DrawerSections.Historique ? true: false),
        menuItem(5, "Bibliothèque", Icons.list, currentPage == DrawerSections.Bibliotheque ? true: false),
        menuItem(6, "Déconnexion", Icons.logout, currentPage == DrawerSections.Deconnexion ? true: false),
      
       ],
    ),
  );
}
Widget menuItem(int id, String title, IconData icon, bool selected){
  return Material(
    color: selected ? Colors.grey[300] : Colors.transparent,
    child: InkWell(
      onTap: (){
      Navigator.pop(context);
      setState(() {
         if(id==1){
          currentPage=DrawerSections.Accueil;
        } else if(id==2){
          currentPage=DrawerSections.NouvelleObservation;
        }else if(id==3){
          currentPage=DrawerSections.NouvelleEspece;
        }
        else if(id==4){
          currentPage=DrawerSections.Historique;
        }else if(id==5){
          currentPage=DrawerSections.Bibliotheque;
        }else if(id==6){
          currentPage=DrawerSections.Deconnexion;
        }
      });
      },
       child: Padding(padding: EdgeInsets.all(5.0),
      child: Row(
        
        children: [
           const SizedBox(width: 20),
           Icon(
            icon,
            size: 20,
            color: Colors.black,
          ),
         const SizedBox(width: 20,height: 50,),
  
       Text(title, style: TextStyle(color: Colors.black, fontSize:16,),),
      ]),),
    )
  );
}
}

enum DrawerSections{
  Accueil,
  NouvelleObservation,
  NouvelleEspece,
  Historique ,
  Bibliotheque,
  Deconnexion,
  Espece,
}