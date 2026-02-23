import 'package:alert_her/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NormalTextBox extends StatelessWidget {
  final String text;
  final double height;
  final double fontSize;
  final double leftMargin;
  final double rightMargin;
  final String? iconPath;
  final Color fillColor;
  final Color borderColor;
  final VoidCallback? onTap;
  final TextAlign textAlign;
  final String labelText;

  const NormalTextBox({
    Key? key,
    required this.text,
    this.height = 48.0,
    this.fontSize = 14.0,
    this.leftMargin = 16.0,
    this.rightMargin = 16.0,
    this.iconPath,
    this.fillColor = Colors.white,
    this.borderColor = MyColors.primary,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.labelText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: height,
            padding: EdgeInsets.only(
              left: leftMargin,
              right: rightMargin,
            ),
            decoration: BoxDecoration(
              color: fillColor,
              border: Border.all(
                color: borderColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: textAlign, // Apply text alignment
                    style: TextStyle(
                      color: MyColors.gray,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                if (iconPath != null) ...[
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: iconPath!.endsWith('.svg')
                        ? SvgPicture.asset(iconPath!)
                        : Image.asset(iconPath!),
                  ),
                ],
              ],
            ),
          ),
          if (labelText.isNotEmpty)
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                labelText,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
