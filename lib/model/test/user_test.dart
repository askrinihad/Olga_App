import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_app/model/user.dart';
import 'package:test_app/BDD/hive_function.dart'; // Assurez-vous d'importer HiveService

class UserTest extends StatefulWidget {
  const UserTest({Key? key}) : super(key: key);

  @override
  _UserTestState createState() => _UserTestState();
}

class _UserTestState extends State<UserTest> {
  late Box<User> userBox;
  final hiveService = HiveService(); // Créez une instance de HiveService

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<User>('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006766),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: userBox.listenable(),
        builder: (context, Box<User> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('No data'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final user = box.getAt(index) as User;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.id.toString()),
                      Text(user.email),
                      Text(user.password ?? ''),
                      Text(user.airport),
                      Text(user.tokenExpiryDate.toString()),
                      Text(user.isLogged.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HiveService
              .clearDataUser(); // Appelle la méthode clearDataUser lorsque le bouton est pressé
        },
        child: Icon(Icons.delete),
        tooltip: 'Supprimer tout',
      ),
    );
  }
}
