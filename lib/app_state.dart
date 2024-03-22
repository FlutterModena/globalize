import 'dart:async' show Timer;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:globalize/models.dart';
import 'package:globalize/util/ext.dart';
import 'package:globalize/util/json.dart';
import 'package:path/path.dart';
import 'consts.dart';

class AppState extends ChangeNotifier {
  static const _debounceDuration = Duration(milliseconds: 500);

  bool _isProjectLoaded = false;
  String? _projectName;
  Directory? _currentProjectDirectory;
  List<FileSystemEntity> projectFiles = [];
  List<String> languages = [];
  Map<String, List<TranslationKey>> keys = {};
  Timer? _debounceTimer;
  File? keysFile;

  bool get isProjectLoaded => _isProjectLoaded;
  String? get projectName => _projectName;
  Directory? get projectDirectory => _currentProjectDirectory;
  List<String> get formattedLanguages => languages.map((langName) {
        var filename = langName.extractFilename();
        return "$langName ($filename)";
      }).toList();

  void editKey({
    required String lang,
    required String key,
    required String newValue,
  }) {
    keys[lang]![keys[lang]!.indexWhere((element) => element.name == key)]
        .value = newValue;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, saveKeys);
    notifyListeners();
  }

  Future<void> deleteKey(int index) async {
    for (var lang in languages) {
      keys[lang]?.removeAt(index);
    }
    await saveKeys();
    notifyListeners();
  }

  void deleteLanguage(String lang) {
    languages.remove(lang);
    keys.remove(lang);
    saveKeys();
    notifyListeners();
  }

  set isProjectLoaded(bool v) {
    _isProjectLoaded = v;
    notifyListeners();
  }

  Future<void> loadLanguages() async {
    projectFiles = await projectDirectory!.list().toList();
    for (var file in projectFiles) {
      final filename = basename(file.path);
      final langName = filename.extractLanguage();
      if (langName != null) {
        languages.add(langName);
      }
    }
    keys.addAll(Map.fromEntries(languages.map((e) => MapEntry(e, []))));
    notifyListeners();
  }

  Future<void> loadKeys() async {
    keysFile = File("${_currentProjectDirectory!.path}/$kKeysFilePath");
    if (await keysFile!.exists()) {
      keys = (json.decode(await keysFile!.readAsString()))
          .map<String, List<TranslationKey>>(
        (String key, value) => MapEntry<String, List<TranslationKey>>(
          key,
          value.map<TranslationKey>((e) => TranslationKey.fromJson(e)).toList(),
        ),
      );
    }
  }

  Future<void> saveKeys() async {
    keysFile ??= File("${_currentProjectDirectory!.path}/$kKeysFilePath");
    await keysFile!.create();
    await keysFile!.writeAsString(
      json.encode(
        keys.map(
          (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList()),
        ),
      ),
    );
    keys.forEach((key, value) async {
      var arbFile =
          File("${_currentProjectDirectory!.path}/${key.extractFilename()}");

      await arbFile.create();

      arbFile.writeAsString(json.encode(value.getJson()));
    });
  }

  Future<void> addLanguage(String lang) async {
    final file = File("${projectDirectory!.path}/$lang");
    await file.create();
    reloadProjectDirectory();
    notifyListeners();
  }

  void addKey(TranslationKey newKey) {
    for (var lang in languages) {
      if (!keys.containsKey(lang)) keys[lang] = [];
      keys[lang]!.add(newKey);
    }

    saveKeys();
    notifyListeners();
  }

  void setProjectName(String v) {
    _projectName = v;
    notifyListeners();
  }

  Future<void> setProjectDirectory(String dir) async {
    formattedLanguages.clear();
    _currentProjectDirectory = Directory(dir);
    await loadLanguages();
    await loadKeys();
    notifyListeners();
  }

  Future<void> reloadProjectDirectory() async {
    await setProjectDirectory(_currentProjectDirectory!.path);
  }
}
