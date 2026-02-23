import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClickableImage extends StatelessWidget {
  final String? svgAsset;
  final String? imageAsset;
  final IconData? icon;
  final double size;
  final Color? color;
  final VoidCallback? onTap;

  const ClickableImage({
    Key? key,
    this.svgAsset,
    this.imageAsset,
    this.icon,
    this.size = 24.0,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (svgAsset != null) {
      child = SvgPicture.asset(
        svgAsset!,
        height: size,
        width: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
      );
    } else if (imageAsset != null) {
      child = Image.asset(
        imageAsset!,
        height: size,
        width: size,
        color: color,
      );
    } else if (icon != null) {
      child = Icon(
        icon,
        size: size,
        color: color,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
