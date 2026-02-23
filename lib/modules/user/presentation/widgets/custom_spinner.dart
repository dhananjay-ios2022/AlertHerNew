import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/my_colors.dart';

class CustomSpinner extends StatefulWidget {
  final double height;
  final double fontSize;
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;
  final bool isEnabled;
  final Icon? dropdownIcon;

  CustomSpinner({
    this.height = 50,
    this.fontSize = 14,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.isEnabled = true,
    this.dropdownIcon,
  });

  @override
  _CustomSpinnerState createState() => _CustomSpinnerState();
}

class _CustomSpinnerState extends State<CustomSpinner> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedItem ?? (widget.items.isNotEmpty ? widget.items[0] : null);
  }

  @override
  void didUpdateWidget(CustomSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update selected value if selectedItem changes or if items change
    if (widget.selectedItem != oldWidget.selectedItem ||
        !listEquals(widget.items, oldWidget.items)) {
      setState(() {
        _selectedValue = widget.selectedItem ?? (widget.items.isNotEmpty ? widget.items[0] : null);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.gray),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: MyColors.gray),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        value: widget.items.contains(_selectedValue) ? _selectedValue : null,
        icon: widget.dropdownIcon ?? const Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.black,
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w400,
        ),
        onChanged: widget.isEnabled
            ? (String? newValue) {
          setState(() {
            _selectedValue = newValue;
          });
          widget.onChanged(newValue);
        }
            : null,
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
