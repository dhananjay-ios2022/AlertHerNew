import 'package:alert_her/core/utils/sb.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final TextStyle readMoreStyle;
  final int maxLines;

  const ReadMoreText({
    Key? key,
    required this.text,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.readMoreStyle = const TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
    this.maxLines = 3,
  }) : super(key: key);

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: text, style: widget.textStyle);
        final tp = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );
        tp.layout(maxWidth: constraints.maxWidth);

        final isOverflowing = tp.didExceedMaxLines;

        return RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _isExpanded ? text: '${text.substring(0, tp.getPositionForOffset(Offset(constraints.maxWidth, tp.height * widget.maxLines)).offset)}...',
                style: widget.textStyle,
              ),
              if (isOverflowing)
                const WidgetSpan(
                  child: SizedBox(width: 5.0),
                ),
              if (isOverflowing)
                TextSpan(
                  text: _isExpanded ? 'Show Less' : 'Read More',
                  style: widget.readMoreStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                ),
            ],
          ),
        );
      },
    );
  }
}