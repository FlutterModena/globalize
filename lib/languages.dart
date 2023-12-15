import 'package:flutter/material.dart';
import 'package:globalize/theming.dart';

class LanguagesView extends StatefulWidget {
  const LanguagesView({super.key});

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {
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
            )
          ],
        ),
      ),
    );
  }
}
