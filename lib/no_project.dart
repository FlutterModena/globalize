import 'package:flutter/material.dart';
import 'package:globalize/theming.dart';

class NoProjectView extends StatelessWidget {
  const NoProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Nessuna cartella selezionata",
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
                        "Sembrerebbe che nessuna cartella sia stata selezionata.\n",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: typoSecondary,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Per cominciare, clicca su \"Seleziona cartella\" nel menù qui a fianco",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: typoSecondary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
