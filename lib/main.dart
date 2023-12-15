import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:globalize/app_state.dart';
import 'package:globalize/chip.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/languages.dart';
import 'package:globalize/no_project.dart';
import 'package:globalize/theming.dart';
import 'package:flutter/material.dart';
import 'package:globalize/translations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AppState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Globalize',
      theme: appTheme(context),
      home: const Entrypoint(),
    );
  }
}

class Entrypoint extends StatefulWidget {
  const Entrypoint({super.key});

  @override
  State<Entrypoint> createState() => _EntrypointState();
}

class _EntrypointState extends State<Entrypoint> {
  var route = -1;

  void _setProject(String res) {
    final state = Provider.of<AppState>(context, listen: false);
    // carica le lingue in base alla terminazione del file!!
    setState(() {
      state.setProjectName(res);
      state.setProjectDirectory(res).then((_) {
        state.isProjectLoaded = true;
        route = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: bg_4,
              ),
              width: 320,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.headlineMedium,
                          children: const [
                            TextSpan(
                              text: "globalize.",
                              style: TextStyle(
                                color: typoMain,
                              ),
                            ),
                            TextSpan(
                              text: "fm",
                              style: TextStyle(
                                color: typoSpecial,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Consumer<AppState>(
                        builder: (context, state, child) => Column(
                          children: [
                            CustomChip(
                              onTap: () {
                                setState(() {
                                  if (!state.isProjectLoaded) return;

                                  route = 0;
                                });
                              },
                              icon: CustomIcons.translate,
                              text: "Traduzioni",
                              selected: route == 0,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomChip(
                              onTap: () {
                                setState(() {
                                  if (!state.isProjectLoaded) return;

                                  route = 1;
                                });
                              },
                              icon: CustomIcons.flag,
                              text: "Lingue",
                              selected: route == 1,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomChip(
                              onTap: () async {
                                final pickResult = await getDirectoryPath();
                                setState(() {
                                  if (pickResult == null) return;
                                  _setProject(pickResult);
                                });
                              },
                              icon: CustomIcons.folder,
                              text: "Seleziona cartella",
                              selected: route == 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Consumer<AppState>(
                        builder: (context, state, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Progetto corrente",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: typoMain,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              state.isProjectLoaded
                                  ? state.projectName!
                                  : "Nessun progetto selezionato",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: typoSecondary,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            route == -1
                ? const NoProjectView()
                : route == 1
                    ? const LanguagesView()
                    : const TranslationsView()
          ],
        ),
      ),
    );
  }
}
