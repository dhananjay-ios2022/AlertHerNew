import 'package:alert_her/core/constants/my_colors.dart';
import 'package:flutter/material.dart';

class TextSubHeading extends StatelessWidget {
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

  const TextSubHeading({
    Key? key,
    required this.text,
    this.fontSize = 12.0,
    this.fontFamily = 'roboto',
    this.color = MyColors.black,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.underline = false,
    this.underlineThickness = 1.0,
    this.underlineColor = MyColors.black,
    this.underlineOffset = 0,
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
            child: Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: fontFamily,
                color: color,
                fontWeight: fontWeight,
              ),
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
