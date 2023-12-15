import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(
    this.iconPath, {
    this.size,
    this.color,
    super.key,
  });

  final String iconPath;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: SvgPicture.asset(
        fit: BoxFit.scaleDown,
        iconPath,
        color: color,
        width: size != null ? size! : 18,
      ),
    );
  }
}

abstract class CustomIcons {
  static const arrowNarrowRight = "assets/arrow-narrow-right.svg";
  static const chevronDown = "assets/chevron-down.svg";
  static const flag = "assets/flag-06.svg";
  static const folder = "assets/folder.svg";
  static const plusCircle = "assets/plus-circle.svg";
  static const translate = "assets/translate-01.svg";
  static const trash = "assets/trash-02.svg";
}
