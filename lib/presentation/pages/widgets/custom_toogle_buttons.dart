import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final void Function() handleToday;
  final void Function() handleWeekly;
  final void Function() handleMonthly;
  const CustomToggleButton({
    super.key,
    required this.handleToday,
    required this.handleWeekly,
    required this.handleMonthly,
  });

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  List<bool> isSelected = [true, false, false];
  List<String> options = ['Today', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) => ToggleButtons(
      borderRadius: BorderRadius.circular(12),
      isSelected: isSelected,
      onPressed: (newIndex) {
        setState(() {
          for (var index = 0; index < isSelected.length; index++) {
            if (index == newIndex) {
              isSelected[index] = true;
              handleToggle(index);
            } else {
              isSelected[index] = false;
            }
          }
        });
      },
      children: options
          .map(
            (option) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(option),
            ),
          )
          .toList());

  void handleToggle(int index) {
    switch (index) {
      case 0:
        widget.handleToday();
        break;
      case 1:
        widget.handleWeekly();
        break;
      case 2:
        widget.handleMonthly();
        break;
    }
  }
}
