import 'package:flutter/material.dart';
import 'package:globalize/app_state.dart';
import 'package:globalize/custom_text_button.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/list_element.dart';
import 'package:globalize/theming.dart';
import 'package:provider/provider.dart';

class TranslationsView extends StatefulWidget {
  const TranslationsView({super.key});

  @override
  State<TranslationsView> createState() => _TranslationsViewState();
}

class _TranslationsViewState extends State<TranslationsView> {
  final Set<String> keys = <String>{};
  var langFrom = "N/A", langTo = "N/A";

  Future<void> _buildDialog(BuildContext context) {
    final theme = Theme.of(context);
    final keyNameController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Aggiungi nuova chiave",
          style: theme.textTheme.headlineMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: keyNameController,
              decoration: const InputDecoration(
                hintText: "Nome chiave",
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
              setState(() {
                keys.add(keyNameController.text);
              });
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
                  "Traduzioni",
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
                            "Da qui è possibile modificare le traduzioni dei file ARB",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                      customIcon: CustomIcons.plusCircle,
                      iconOnly: false,
                      text: "Aggiungi nuova chiave",
                      onPressed: () async {
                        await _buildDialog(context);
                      },
                    ),
                    Row(
                      children: [
                        Consumer<AppState>(
                          builder: (context, state, _) => DropdownMenu(
                            onSelected: (from) {
                              setState(() {
                                langFrom = from!;
                              });
                            },
                            dropdownMenuEntries: state.formattedLanguages
                                .map(
                                  (lan) => DropdownMenuEntry(
                                    value: lan,
                                    label: lan.split(" ")[0],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        const CustomIcon(CustomIcons.arrowNarrowRight),
                        const SizedBox(
                          width: 16,
                        ),
                        Consumer<AppState>(
                          builder: (context, state, _) => DropdownMenu(
                            onSelected: (to) {
                              setState(() {
                                langTo = to!;
                              });
                            },
                            dropdownMenuEntries: state.formattedLanguages
                                .map(
                                  (lan) => DropdownMenuEntry(
                                    value: lan,
                                    label: lan.split(" ")[0],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      380, // giusto per farla vedere bene sullo schermo quando è fullscreen
                  child: OverflowBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox.expand(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: keys
                                    .map(
                                      (k) => Column(
                                        children: [
                                          ListElement(
                                            text: k,
                                            onDelete: () {},
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: SizedBox.expand(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  langFrom,
                                  style:
                                      theme.textTheme.headlineMedium!.copyWith(
                                    color: typoMain,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: bg_3,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                      style:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: typoMain,
                                      ),
                                      maxLines: null,
                                      expands: true,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  langTo,
                                  style:
                                      theme.textTheme.headlineMedium!.copyWith(
                                    color: typoMain,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: bg_3,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: TextFormField(
                                      style:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: typoMain,
                                      ),
                                      maxLines: null,
                                      expands: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
