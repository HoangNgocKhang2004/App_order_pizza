import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value); // Đổi trạng thái khi nhấn
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 16, // Kích cỡ checkbox
        height: 16,
        decoration: BoxDecoration(
          color: value ? activeColor : Colors.transparent,
          border: Border.all(
            color: value ? activeColor : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(2), // Hình vuông bo góc
        ),
        child: value
          ? Center(
              child: Icon(
                Icons.check,
                color: checkColor,
                size: 10, // Kích cỡ dấu tích
              ),
            )
          : null,
      ),
    );
  }
}