import 'package:alert_her/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class NormalTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final double leftMargin;
  final double rightMargin;
  final String? iconPath;
  final TextInputType inputType;
  final String? defaultText;
  final bool isEnabled;
  final ValueChanged<String>? onChanged;
  final bool addStaticPrefix;
  final bool isOTP;
  final String staticPrefix;
  final double letterSpacing;
  final double borderRadius;
  final double iconSpaceFromTop;
  final double iconSpaceFromBottom;
  Color? fillColor;
  Color fillActiveColor;
  Color? disableColor;
  Color? disableTextColor;
  final VoidCallback? onSuffixIconTap;
  final FocusNode? focusNode;

  NormalTextField({
    Key? key,
    this.hintText,
    this.addStaticPrefix = false,
    this.staticPrefix = '+44 ',
    this.controller,
    this.obscureText = false,
    this.height = 48.0,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w400,
    this.leftMargin = 16.0,
    this.rightMargin = 16.0,
    this.iconPath,
    this.inputType = TextInputType.text,
    this.defaultText,
    this.isEnabled = true,
    this.isOTP = false,
    this.onChanged,
    this.letterSpacing = 0.0,
    this.borderRadius = 8.0,
    this.iconSpaceFromTop = 10,
    this.iconSpaceFromBottom = 0,
    this.fillColor = Colors.white,
    this.fillActiveColor = MyColors.primaryLight,
    this.disableColor,
    this.disableTextColor,
    this.onSuffixIconTap,
    this.focusNode,
  }) : super(key: key);

  @override
  State<NormalTextField> createState() => _NormalTextFieldState();
}

class _NormalTextFieldState extends State<NormalTextField> {
  late TextEditingController _controller;
  Color _dynamicFillColor = MyColors.white;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.addStaticPrefix) {
      _controller.text = widget.staticPrefix;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    _controller.addListener(_updateFillColor);
  }

  void _updateFillColor() {
    if (mounted) {
      setState(() {
        _dynamicFillColor = _controller.text.isEmpty
            ? MyColors.white
            : widget.fillActiveColor;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateFillColor);

    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          TextField(
            focusNode: widget.focusNode,
            controller: _controller,
            obscureText: widget.obscureText,
            keyboardType: widget.inputType,
            enabled: widget.isEnabled,
            onChanged: widget.onChanged,
            inputFormatters: [
              if (widget.isOTP) ...[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ] else if (widget.addStaticPrefix)
                TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    if (!newValue.text.startsWith(widget.staticPrefix)) {
                      return oldValue;
                    }
                    return newValue;
                  },
                ),
            ],
            decoration: InputDecoration(
              hintText: widget.hintText,
              counterText: "",
              hintStyle: TextStyle(
                color: MyColors.grayDark,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.normal,
              ),
              labelStyle: const TextStyle(
                color: MyColors.gray,
                letterSpacing: 0.0,
                fontWeight: FontWeight.normal,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: MyColors.gray,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: MyColors.gray,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: MyColors.gray,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              filled: true,
              fillColor: widget.isEnabled ? _dynamicFillColor : (widget.disableColor != null) ? widget.disableColor : MyColors.gray,
              contentPadding: EdgeInsets.only(
                left: widget.leftMargin,
                right: widget.iconPath != null
                    ? widget.rightMargin + 8.0
                    : widget.rightMargin,
                top: 16.0,
                bottom: 16.0,
              ),
            ),
            style: TextStyle(
              color: widget.isEnabled ? MyColors.black : (widget.disableTextColor != null) ? widget.disableTextColor : MyColors.gray,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              letterSpacing: widget.letterSpacing,
            ),
          ),
          if (widget.iconPath != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: widget.onSuffixIconTap,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: widget.rightMargin,
                      left: 6,
                      top: widget.iconSpaceFromTop,
                      bottom: widget.iconSpaceFromBottom,
                    ),
                    child: widget.iconPath!.endsWith('.svg')
                        ? SvgPicture.asset(widget.iconPath!)
                        : Image.asset(widget.iconPath!),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
