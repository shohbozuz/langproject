    // lang_state.dart
    import 'package:freezed_annotation/freezed_annotation.dart';
    import 'package:flutter/material.dart';

    part 'lang_state.freezed.dart';

    @freezed
    class LangState with _$LangState {
      const factory LangState.initial() = _Initial;
      const factory LangState.changed(Locale newLocale) = _Changed;
    }
