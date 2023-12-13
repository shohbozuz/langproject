import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // WidgetsFlutterBinding ni ishga tushirish
  WidgetsFlutterBinding.ensureInitialized();
  // Easy Localization ni ishga tushirish
  await EasyLocalization.ensureInitialized();

  // Shared preferences  olish
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Saqlangan tilni olish
  String? savedLocale = prefs.getString('locale');

  // Agar saqlangan til mavjud bo'lsa, uning obyektini yaratish, aks holda rus tiliga o'rnating
  Locale savedLocaleObj = savedLocale != null
      ? Locale(savedLocale.split('_')[0], savedLocale.split('_')[1])
      : Locale('uz', 'UZ'); // Default til rus tiliga o'rnating

  // Ilovaning boshlanishi
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('uz', 'UZ'), Locale('ru', 'RU'), Locale('en', 'US')],
      path: 'assets/translations', // JSON fayllar joylashgan papka
      fallbackLocale: savedLocaleObj, // Agar saqlangan til mavjud bo'lsa, saqlangan tilni o'rnating, aks holda rus tiliga o'rnating
      startLocale: savedLocaleObj, // Ilova boshlanganida tilni o'qish uchun ishlatiladigan locale
      saveLocale: true, // Tilni saqlash
      useOnlyLangCode: true, // Zabt etilgan tilda til kodini qo'llash
      child: MyApp(), // Ilovaning boshqa qismi
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
      locale: context.locale, // Hozirgi tilni olish
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title').tr(), // 'title' kalit so'zini o'qish
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hello_world').tr(), // 'hello_world's kalit so'zini o'qish
            Text("love").tr(),
            ElevatedButton(
              onPressed: () async {
                // Tillarni almashish
                context.setLocale(Locale('uz', 'UZ'));
                saveLocale('uz_UZ'); // Saqlash
              },
              child: Text("uzbek".tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                // Tillarni almashish
                context.setLocale(Locale('ru', 'RU'));
                saveLocale('ru_RU'); // Saqlash
              },
              child: Text('russian'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                // Tillarni almashish uchun
                context.setLocale(Locale('en', 'US'));
                saveLocale('en_US'); // Saqlash
              },
              child: Text('english'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  // Tilni saqlash uchun funksiya
  Future<void> saveLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
  }
}
