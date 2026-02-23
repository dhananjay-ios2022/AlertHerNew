import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/my_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final double height;
  final Color textColor;
  final Color? bgColor;
  final double textSize;
  final FontWeight fontWeight;
  final bool isLoading;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final double? radius;

  const PrimaryButton({
    Key? key,
    required this.buttonText,
    this.height = 48.0,
    this.textColor = Colors.white,
    this.bgColor,
    this.textSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.isLoading = false,
    this.isDisabled = false,
    this.onPressed,
    this.radius = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(

          backgroundColor: isDisabled ? MyColors.gray : (bgColor != null) ? bgColor : MyColors.primary,
          foregroundColor: isDisabled ? Colors.white : textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Visibility(
              visible: !isLoading,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: textSize,
                  fontWeight: fontWeight,
                  color: isDisabled ? MyColors.black : textColor,
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: CupertinoActivityIndicator(
                radius: 12.0,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
