import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/constants/core_constants.dart';
import 'package:flutter_template/core/di/injection_container.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';

final localeProvider = FutureProvider<Locale>((ref) async {
  final localStorageService = sl<ILocalStorageService>();
  final langCode = await localStorageService.getData(CoreConstants.languageCodeKey) ?? CoreConstants.defaultLanguageCode;
  return Locale(langCode);
});


