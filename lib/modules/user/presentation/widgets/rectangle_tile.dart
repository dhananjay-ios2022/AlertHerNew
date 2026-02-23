import 'package:alert_her/core/comman_widgets/text_sub_heading.dart';
import 'package:alert_her/core/constants/my_colors.dart';
import 'package:alert_her/core/utils/sb.dart';
import 'package:flutter/material.dart';

class RectangleTile extends StatelessWidget {
  final String title;
  final String value;
  final Color bg;

  const RectangleTile({
    required this.title,
    required this.value,
    this.bg = MyColors.primaryLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSubHeading(text: value,fontSize: 25),
          TextSubHeading(text: title,fontSize: 14),
        ],
      ),
    );
  }
}