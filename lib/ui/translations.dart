import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globalize/app_state.dart';
import 'package:globalize/models.dart';
import 'package:globalize/ui/custom_text_button.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/ui/list_element.dart';
import 'package:globalize/theming.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TranslationsView extends StatefulWidget {
  const TranslationsView({super.key});

  @override
  State<TranslationsView> createState() => _TranslationsViewState();
}

class _TranslationsViewState extends State<TranslationsView> {
  late Map<String, List<TranslationKey>> keys;
  late List<String> languages;
  late AppState state;
  int _selectedIndex = 0;
  var _langFrom = "N/A", _langTo = "N/A";
  var textFrom = TextEditingController(), textTo = TextEditingController();
  bool initializedTextFields = false;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int n) {
    _selectedIndex = n;
    initTextFields();
  }

  set langFrom(String n) {
    _langFrom = n;
    initTextFields();
  }

  set langTo(String n) {
    _langTo = n;
    initTextFields();
  }

  String get langFrom => _langFrom;
  String get langTo => _langTo;

  String get langFromShort => langFrom.split(" ")[0];
  String get langToShort => langTo.split(" ")[0];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    state = context.watch<AppState>();
    keys = state.keys;
    languages = state.languages;
  }

  void textListener(String lang, TextEditingController controller) {
    if (!initializedTextFields) return;

    if (keys[lang] == null) return;
    state.editKey(
      lang: lang,
      key: keys[lang]![selectedIndex].name,
      newValue: controller.text,
    );
  }

  void textFromListener() {
    textListener(langFromShort, textFrom);
  }

  void textToListener() {
    textListener(langToShort, textTo);
  }

  void initTextFields() {
    if (keys[langFromShort] != null) {
      textFrom.text = keys[langFromShort]![selectedIndex].value;
    }
    if (keys[langToShort] != null) {
      textTo.text = keys[langToShort]![selectedIndex].value;
    }
    initializedTextFields = true;
  }

  @override
  void initState() {
    //TODO:initialize text
    super.initState();

    textFrom.addListener(textFromListener);
    textTo.addListener(textToListener);
  }

  Future<void> _buildDialog(BuildContext context) async {
    final theme = Theme.of(context);

    var newKey = await showDialog<TranslationKey>(
      context: context,
      builder: (context) => AddKeyDialog(theme: theme, mounted: mounted),
    );
    if (newKey != null) {
      setState(() {
        state.addKey(newKey);
      });
    }
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
                  AppLocalizations.of(context)!.translations,
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
                                children: keys.entries.isEmpty
                                    ? []
                                    : keys.entries.first.value
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = entry.key;
                                                  });
                                                },
                                                child:
                                                    TranslationKeyListElement(
                                                  translationKey: entry.value,
                                                  selected: selectedIndex ==
                                                      entry.key,
                                                  onDelete: () {
                                                    state.deleteKey(entry.key);
                                                  },
                                                ),
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
                                      controller: textFrom,
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
                                      controller: textTo,
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

class AddKeyDialog extends StatefulWidget {
  const AddKeyDialog({
    super.key,
    required this.theme,
    required this.mounted,
  });

  final ThemeData theme;
  final bool mounted;

  @override
  State<AddKeyDialog> createState() => _AddKeyDialogState();
}

class _AddKeyDialogState extends State<AddKeyDialog> {
  var keyNameController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      title: Text(
        "Aggiungi chiave",
        style: widget.theme.textTheme.headlineMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [],
          ),
          _getGeneralInfo(),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            "Annulla",
            style: widget.theme.textTheme.labelMedium,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            "Aggiungi",
            style: widget.theme.textTheme.labelMedium,
          ),
          onPressed: () async {
            if (widget.mounted) {
              Navigator.of(context).pop(TranslationKey(
                  name: keyNameController.text,
                  description: descriptionController.text,
                  variables: []));
            }
          },
        ),
      ],
    );
  }

  Widget _getGeneralInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: keyNameController,
          decoration: const InputDecoration(
            hintText: "Nome chiave",
          ),
        ),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            hintText: "Descrizione della chiave generica",
          ),
        ),
      ],
    );
  }

  Widget _getAdvancedInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: keyNameController,
          decoration: const InputDecoration(
            hintText: "Nome chiave",
          ),
        ),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            hintText: "Descrizione della chiave generica",
          ),
        ),
      ],
    );
  }
}
