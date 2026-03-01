import 'package:flutter/widgets.dart';
import 'package:practice/data/repositories/Setting/appSettings_repository.dart';

import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  AppSettings? _appSettings;
  final AppsettingsRepository _repository;

  AppSettingsState(this._repository);

  Future<void> init() async {
    // Might be used to load data from repository
    _appSettings = await _repository.load();
    notifyListeners();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(themeColor: themeColor);

    await _repository.save(_appSettings!);

    notifyListeners();
  }
}
