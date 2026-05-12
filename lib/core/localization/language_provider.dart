import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/constants/core_constants.dart';
import 'package:flutter_template/core/storage/i_local_storage_service.dart';
import 'package:flutter_template/core/di/service_locator.dart';

final localeProvider = FutureProvider<Locale>((ref) async {
  final localStorageService = sl<ILocalStorageService>();
  final langCode = await localStorageService.getData(CoreConstants.languageCodeKey) ?? CoreConstants.defaultLanguageCode;
  return Locale(langCode);
});


