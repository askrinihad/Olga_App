import 'package:flutter/material.dart';
import 'package:test_app/language/Language.dart';
import 'package:test_app/language/language_constants.dart';
import 'package:test_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_app/style/StyleText.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // The UI consists of a Container with a Column of widgets.
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
          ],
        ),
      ),
    );
  }
}
