import 'package:flutter/material.dart';

class obsInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  const obsInfo({required this.item, super.key});

  @override
  State<obsInfo> createState() => _obsInfoState();
}

class _obsInfoState extends State<obsInfo> {
  late String imageUrl='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 17, 31, 157),
      ),
     body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 300,
        child: Image(
          image: NetworkImage(widget.item["imageUrl"]), // Corrected this line
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Observé le : ${widget.item["date"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Phase : ${widget.item["phase"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Nombre: ${widget.item["nombre"]} individu (s)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Etat : ${widget.item["etat"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Action : ${widget.item["action"]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

    );
  }
}