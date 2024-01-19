// main.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/lang/lang_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLocale = prefs.getString('locale');
  Locale savedLocaleObj = savedLocale != null
      ? Locale(savedLocale.split('_')[0], savedLocale.split('_')[1])
      : Locale('uz', 'UZ');

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('uz', 'UZ'),
        Locale('ru', 'RU'),
        Locale('en', 'US'),
      ],
      path: 'assets/translations',
      fallbackLocale: savedLocaleObj,
      startLocale: savedLocaleObj,
      saveLocale: true,
      useOnlyLangCode: true,
      child: BlocProvider(
        create: (context) => LangCubit(context),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    Color defaultButtonColor = Colors.white10;
    Color selectedButtonColor = Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: Text('title').tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello_world').tr(),
            Text("love").tr(),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<LangCubit>(context)
                    .changeLanguage(Locale('uz', 'UZ'));
              },
              style: ElevatedButton.styleFrom(
                primary: currentLocale.languageCode == 'uz'
                    ? selectedButtonColor
                    : defaultButtonColor,
              ),
              child: Text("uzbek".tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<LangCubit>(context)
                    .changeLanguage(Locale('ru', 'RU'));
              },
              style: ElevatedButton.styleFrom(
                primary: currentLocale.languageCode == 'ru'
                    ? selectedButtonColor
                    : defaultButtonColor,
              ),
              child: Text('russian'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                BlocProvider.of<LangCubit>(context)
                    .changeLanguage(Locale('en', 'US'));
              },
              style: ElevatedButton.styleFrom(
                primary: currentLocale.languageCode == 'en'
                    ? selectedButtonColor
                    : defaultButtonColor,
              ),
              child: Text('english'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
