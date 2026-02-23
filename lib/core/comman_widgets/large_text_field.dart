import 'package:alert_her/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LargeTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool isEnabled;
  final bool isAddMaxWord;
  Color? disableColor;

  LargeTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.isEnabled = true,
    this.isAddMaxWord = false,
    this.disableColor,
  }) : super(key: key);

  @override
  State<LargeTextField> createState() => _LargeTextFieldState();
}

class _LargeTextFieldState extends State<LargeTextField> {
  late TextEditingController _controller;
  final int maxWords = 200;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    // Add a listener to update the state when the text changes
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // Check if the widget is mounted before calling setState
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // Remove the listener
    _controller.removeListener(_onTextChanged);

    // Dispose the controller if it was created locally
    if (widget.controller == null) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color dynamicFillColor = _controller.text.isEmpty
        ? MyColors.white
        : MyColors.primaryLight;

    return TextField(
      controller: _controller,
      maxLines: 6,
      inputFormatters: widget.isAddMaxWord ? [
         WordLimitFormatter(maxWords),
      ] : null,
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: "",
        hintStyle: const TextStyle(
          color: MyColors.grayDark,
          fontSize: 14,
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
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: MyColors.gray,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: widget.isEnabled ? dynamicFillColor : (widget.disableColor != null) ? widget.disableColor : MyColors.gray,
      ),
      style: const TextStyle(
        color: MyColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class WordLimitFormatter extends TextInputFormatter {
  final int maxWords;

  WordLimitFormatter(this.maxWords);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var words = newValue.text.trim().split(RegExp(r'\s+'));
    if (words.length > maxWords) {
      // Truncate text to the first maxWords words
      var truncatedText = words.take(maxWords).join(' ');
      return TextEditingValue(
        text: truncatedText,
        selection: TextSelection.collapsed(offset: truncatedText.length),
      );
    }
    return newValue; // Allow the new value if within limit
  }
}

