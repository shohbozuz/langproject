// lang_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:langproject/cubit/lang/lang_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangCubit extends Cubit<LangState> {
  final BuildContext context; // Add this line to store the context

  LangCubit(this.context) : super(const LangState.initial());

  Future<void> changeLanguage(Locale newLocale) async {
    EasyLocalization.of(context)!.setLocale(newLocale); // Use EasyLocalization.of to get the localization delegate
    await saveLocale(newLocale.languageCode + '_' + newLocale.countryCode!);
    emit(LangState.changed(newLocale));
  }

  Future<void> saveLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale);
  }
}
