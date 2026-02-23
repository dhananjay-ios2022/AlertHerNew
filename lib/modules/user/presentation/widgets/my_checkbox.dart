import 'package:alert_her/core/constants/my_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final Color activeColor;
  final Color borderColor;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    this.activeColor = MyColors.primary,
    this.borderColor = MyColors.blackLight,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.value ? widget.activeColor : widget.borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: widget.value
            ? Icon(
          Icons.check,
          color: widget.activeColor,
          size: 16.0,
        )
            : null,
      ),
    );
  }
}

