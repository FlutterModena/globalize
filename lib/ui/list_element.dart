import 'package:flutter/material.dart';
import 'package:globalize/models.dart';
import 'package:globalize/ui/custom_text_button.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/theming.dart';

class TranslationKeyListElement extends StatelessWidget {
  final TranslationKey translationKey;
  final VoidCallback onDelete;
  final bool selected;
  const TranslationKeyListElement({
    super.key,
    required this.selected,
    required this.translationKey,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 770,
      ),
      width: double.infinity,
      height: 85,
      decoration: BoxDecoration(
        color: selected ? bg_2 : bg_4,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              translationKey.name,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: selected ? typoOnColor : typoMain,
              ),
            ),
            const Spacer(),
            CustomTextButton(
              customIcon: CustomIcons.trash,
              iconOnly: true,
              dark: selected,
              iconColor: selected ? typoMain : typoOnColor,
              onPressed: onDelete,
            )
          ],
        ),
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  final String text;
  final VoidCallback onDelete;
  const ListElement({
    super.key,
    required this.text,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 770,
      ),
      width: double.infinity,
      height: 85,
      decoration: BoxDecoration(
        color: bg_4,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: typoMain,
              ),
            ),
            const Spacer(),
            CustomTextButton(
              customIcon: CustomIcons.trash,
              iconOnly: true,
              iconColor: typoOnColor,
              onPressed: onDelete,
            )
          ],
        ),
      ),
    );
  }
}
