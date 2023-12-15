import 'package:globalize/chip.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/theming.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  var isProjectLoaded = false;
  List<PlatformFile> files = [];

  void _setProject(FilePickerResult res) {
    setState(() {
      files = res.files;
      isProjectLoaded = true;
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
              child: Padding(
                padding: const EdgeInsets.all(40.0),
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
                    Column(
                      children: [
                        CustomChip(
                          onTap: () {
                            setState(() {
                              if (!isProjectLoaded) return;

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
                              if (!isProjectLoaded) return;

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
                            print("picking...");
                            final pickResult =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                            );
                            setState(() {
                              route = 2;
                              print(pickResult);
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
                    const SizedBox(
                      height: 48,
                    ),
                    Column(
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
                          "Nessun progetto selezionato",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: typoSecondary,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
