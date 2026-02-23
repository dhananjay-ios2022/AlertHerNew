import 'package:alert_her/core/constants/const_images.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagWithText extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color bgColor;
  final Color? isSelectedColor;
  final double strockWidth;
  final bool isLoading;

  const FlagWithText({
    required this.text,
    required this.borderColor,
    required this.bgColor,
    this.isSelectedColor,
    this.strockWidth = 1,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: (isSelectedColor != null) ? isSelectedColor! : borderColor,
          width: strockWidth,
        ),
      ),
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SvgPicture.asset(
                      ConstImages.flag,
                      colorFilter: ColorFilter.mode(borderColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              SB.w(10),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CupertinoActivityIndicator(
                radius: 10.0,
                color: borderColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}