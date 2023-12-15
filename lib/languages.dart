import 'dart:io';

import 'package:flutter/material.dart';
import 'package:globalize/app_state.dart';
import 'package:globalize/custom_text_button.dart';
import 'package:globalize/ext.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/list_element.dart';
import 'package:globalize/theming.dart';
import 'package:provider/provider.dart';

class LanguagesView extends StatefulWidget {
  const LanguagesView({super.key});

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {
  late Future<List<FileSystemEntity>> currentDir;

  Future<void> _writeNewLanguageFile(String path) async {
    final file = File(path);
    await file.create();
  }

  Future<void> _buildDialog(BuildContext context) {
    final theme = Theme.of(context);
    final languageController = TextEditingController();
    final state = Provider.of<AppState>(context, listen: false);

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Aggiungi nuova lingua",
          style: theme.textTheme.headlineMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: languageController,
              decoration: const InputDecoration(
                hintText: "Nome lingua",
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Annulla",
              style: theme.textTheme.labelMedium,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Aggiungi",
              style: theme.textTheme.labelMedium,
            ),
            onPressed: () async {
              await _writeNewLanguageFile(
                  "${state.projectDirectory!.path}/${languageController.text.extractFilename()}");
              await state.reloadProjectDirectory();
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Lingue",
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: typoMain,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Da qui è possibile modificare e inserire le lingue del progetto selezionato",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: typoSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextButton(
                  customIcon: CustomIcons.plusCircle,
                  iconOnly: false,
                  text: "Aggiungi",
                  onPressed: () {
                    _buildDialog(context);
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Consumer<AppState>(
                  builder: (context, state, _) {
                    return Column(
                      children: state.formattedLanguages
                          .map(
                            (lang) => Column(
                              children: [
                                ListElement(
                                  text: lang,
                                  onDelete: () {
                                    print("delete!");
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                )
                              ],
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
