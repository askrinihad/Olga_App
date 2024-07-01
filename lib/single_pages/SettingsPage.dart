import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/inventory/AddInventory.dart';
import 'package:test_app/language/Language.dart';
import 'package:test_app/language/language_constants.dart';
import 'package:test_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/navbar/NavBackbar.dart';
import 'package:test_app/style/StyleText.dart';
import 'package:test_app/BDD/hive_function.dart';

class SettingsPage extends StatefulWidget {
  final String email;
  final String aeroport;

  const SettingsPage({Key? key, required this.email, required this.aeroport})
      : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ValueNotifier<String> _selectedCodeInventory = ValueNotifier('');
  HiveService hiveService = HiveService();

  void saveCode(String code) async {
    await HiveService.saveCode(code);
  }

  @override
  void initState() {
    super.initState();
    _loadInitialCodeInventory();
  }

  Future<void> _loadInitialCodeInventory() async {
    var user = await hiveService.getUser();
    String initialCode = user?.inventoryCode ?? '';
    _selectedCodeInventory.value = initialCode;
  }

  @override
  Widget build(BuildContext context) {
    // The UI consists of a Container with a Column of widgets.
    return Container(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(
        height: 50,
      ),

      // The title of the page
      Text(
        AppLocalizations.of(context)!.parametre,
        style: StyleText.getTitle(),
      ),

      // A SizedBox is used to add space between the title and the DropdownButton.
      SizedBox(
        height: 100,
      ),

      // A DropdownButton allows the user to select a language. When a language is selected, the locale is updated.
      DropdownButton<Language>(
        iconSize: 25,
        hint: Text(AppLocalizations.of(context)!.changeLanguage,
            style: StyleText.getHintForm()),
        onChanged: (Language? language) async {
          if (language != null) {
            Locale _locale = await setLocale(language.languageCode);
            MyApp.setLocale(context, _locale);
          }
        },

        // The items of the DropdownButton are the languages in the Language.languageList() list.
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

      // Sizebox to add space
      SizedBox(
        height: 100,
      ),

      // The title of the page
      Text(
        AppLocalizations.of(context)!.codeInventaire,
        style: StyleText.getTitle(size: 13),
      ),
      SizedBox(
        height: 25,
      ),
      Center(
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006766),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  )),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NavBackbar(
                        body: AddInventory(
                            email: widget.email, aeroport: widget.aeroport))));
              },
              child:
                  Icon(Icons.add, color: Color.fromRGBO(255, 255, 255, 0.66)),
            ),
            SizedBox(
              width: 50,
            ),
            ValueListenableBuilder<String>(
              valueListenable: _selectedCodeInventory,
              builder: (context, value, child) {
                return FutureBuilder<List<String>>(
                  future: getInventoryCode(widget.aeroport, widget.email), // Fetch all inventory codes
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return DropdownButton<String>(
                        value: value.isNotEmpty ? value : null,
                        iconSize: 25,
                        hint: Text(AppLocalizations.of(context)!.codeInventaire, style: StyleText.getHintForm()),
                        items: snapshot.data!.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Update the selected inventory code
                          _selectedCodeInventory.value = newValue ?? '';
                          // Save the selected code to Hive database
                          saveCode(newValue ?? '');
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Show a loading indicator while the future is in progress
                      return CircularProgressIndicator();
                    }
                  },
                );
              },
            )
          ]))
    ])));
  }
}