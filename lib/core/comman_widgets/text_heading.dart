import 'package:alert_her/core/constants/my_colors.dart';
import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final bool underline;
  final double underlineThickness;
  final Color underlineColor;
  final double underlineOffset;
  final Widget? icon;
  final TextOverflow overflow;
  final bool? softwrap;
  final int maxLines;

  const TextHeading({
    Key? key,
    required this.text,
    this.fontSize = 21.0,
    this.fontFamily = 'roboto',
    this.color = MyColors.black,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.underline = false,
    this.underlineThickness = 1.0,
    this.underlineColor = MyColors.black,
    this.underlineOffset = 0,
    this.icon,
    this.overflow = TextOverflow.clip,
    this.softwrap,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: underline ? underlineOffset : 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 5),
                ],
                Text(
                  text,
                  textAlign: textAlign,
                  overflow: overflow,
                  softWrap: softwrap,
                  maxLines: maxLines,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    color: color,
                    fontWeight: fontWeight,
                  ),
                ),
              ],
            ),
          ),
          if (underline)
            Positioned(
              bottom: 0,
              child: Container(
                height: underlineThickness,
                width: (fontSize * text.length) * 0.6,
                color: underlineColor,
              ),
            ),
        ],
      ),
    );
  }
}
