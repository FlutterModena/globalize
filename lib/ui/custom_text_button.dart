import 'package:flutter/material.dart';
import 'package:globalize/icons.dart';
import 'package:globalize/theming.dart';

class CustomTextButton extends StatelessWidget {
  final String customIcon;
  final bool iconOnly;
  final String? text;
  final Color? iconColor;
  final bool dark;
  final VoidCallback onPressed;
  const CustomTextButton({
    super.key,
    required this.customIcon,
    required this.iconOnly,
    required this.onPressed,
    this.iconColor,
    this.dark = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!iconOnly) {
      assert(text != null);
    }

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: dark ? bg_4 : bg_2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(iconOnly ? 8.0 : 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!iconOnly)
              Row(
                children: [
                  Text(
                    text!,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: typoOnColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            CustomIcon(
              customIcon,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
