import 'package:globalize/icons.dart';
import 'package:globalize/theming.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String icon;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const CustomChip({
    super.key,
    required this.icon,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? bg_2 : bg_1,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
            24,
          ),
          child: Row(
            children: [
              CustomIcon(
                icon,
                color: selected ? typoOnColor : typoMain,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: selected ? typoOnColor : typoMain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
