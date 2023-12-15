import 'dart:io';

import 'package:flutter/material.dart';
import 'package:globalize/ext.dart';
import 'package:path/path.dart';

class AppState extends ChangeNotifier {
  bool _isProjectLoaded = false;
  String? _projectName;
  Directory? _currentProjectDirectory;
  List<FileSystemEntity> projectFiles = [];
  List<String> formattedLanguages = [];

  bool get isProjectLoaded => _isProjectLoaded;
  String? get projectName => _projectName;
  Directory? get projectDirectory => _currentProjectDirectory;

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
        formattedLanguages.add("$langName ($filename)");
      }
    }
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
    notifyListeners();
  }

  Future<void> reloadProjectDirectory() async {
    await setProjectDirectory(_currentProjectDirectory!.path);
  }
}
