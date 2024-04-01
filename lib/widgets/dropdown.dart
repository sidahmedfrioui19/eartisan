import 'package:flutter/material.dart';

class RoundedDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?) onChanged;
  final String hintText;
  final IconData? icon;

  const RoundedDropdownButton({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hintText,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<T>(
          isExpanded: true,
          underline: SizedBox(),
          icon: icon != null ? Icon(icon) : null,
          value: value,
          onChanged: onChanged,
          items: items,
          hint: Text(
            hintText,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
