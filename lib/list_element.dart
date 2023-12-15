import 'package:flutter/material.dart';
import 'package:globalize/custom_text_button.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/theming.dart';

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
