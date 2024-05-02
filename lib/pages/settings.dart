import 'package:flutter/material.dart';
import 'package:test_app/language/language.dart';
import 'package:test_app/language/language_constants.dart';
import 'package:test_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              AppLocalizations.of(context)!.parametre,
              style: TextStyle(
                color: Color(0xFF006766),
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: 'Hind Siliguri',
              ),
            ),
            SizedBox(
              height: 100,
            ),
            DropdownButton<Language>(
              iconSize: 25,
              hint: Text(AppLocalizations.of(context)!.changeLanguage,
                  style: TextStyle(fontSize: 13, fontFamily: 'Hind Siliguri')),
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
          ],
        ),
      ),
    );
  }
}
