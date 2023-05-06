import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final String? labelText;
  final List<T> items;
  final String Function(T) itemToString;
  final void Function(T) onChanged;
  final T? value;
  final String? errorText;

  const CustomDropdownButton({
    Key? key,
    this.labelText,
    required this.items,
    required this.itemToString,
    required this.onChanged,
    this.value,
    this.errorText,
  }) : super(key: key);

  @override
  _CustomDropdownButtonState<T> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText!),
          GestureDetector(
            onTap: () => setState(() => _isOpen = !_isOpen),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _isOpen ? Colors.blue : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.value != null
                        ? widget.itemToString(widget.value!)
                        : '',
                    style: TextStyle(
                      color: widget.value != null ? Colors.black : Colors.grey,
                      fontSize: widget.value != null ? 16.0 : 14.0,
                    ),
                  ),
                  Icon(
                    _isOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.errorText!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}