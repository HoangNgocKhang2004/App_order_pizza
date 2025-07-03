import 'package:app_food_delivery/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const CustomTimePicker({
    Key? key,
    required this.initialTime,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late bool isAM;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hourOfPeriod;
    selectedMinute = widget.initialTime.minute;
    isAM = widget.initialTime.period == DayPeriod.am;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Chọn giờ
        SizedBox(
          width: 60,
          height: 150,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedHour = index == 0 ? 12 : index;
                widget.onTimeChanged(TimeOfDay(
                  hour: isAM ? selectedHour : selectedHour + 12,
                  minute: selectedMinute,
                ));
              });
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List.generate(12, (index) {
                final hour = index == 0 ? 12 : index;
                return Center(
                  child: Text(
                    hour.toString(),
                    style: TextStyle(
                      fontSize: 24, // Kích thước chữ của giờ
                      fontWeight: FontWeight.bold,
                      color: selectedHour == hour ? AppColors.primary : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        // Dấu hai chấm
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            ':',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        // Chọn phút
        SizedBox(
          width: 60,
          height: 150,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedMinute = index;
                widget.onTimeChanged(TimeOfDay(
                  hour: isAM ? selectedHour : selectedHour + 12,
                  minute: selectedMinute,
                ));
              });
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: List.generate(60, (index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 24, // Kích thước chữ của phút
                      fontWeight: FontWeight.bold,
                      color: selectedMinute == index ? AppColors.primary : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        // Chọn AM/PM
        SizedBox(
          width: 60,
          height: 150,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                isAM = index == 0;
                widget.onTimeChanged(TimeOfDay(
                  hour: isAM ? selectedHour : selectedHour + 12,
                  minute: selectedMinute,
                ));
              });
            },
            childDelegate: ListWheelChildListDelegate(
              children: [
                Center(
                  child: Text(
                    'AM',
                    style: TextStyle(
                      fontSize: 20, // Kích thước chữ của AM/PM
                      fontWeight: FontWeight.bold,
                      color: isAM ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'PM',
                    style: TextStyle(
                      fontSize: 20, // Kích thước chữ của AM/PM
                      fontWeight: FontWeight.bold,
                      color: !isAM ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}