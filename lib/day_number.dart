import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/utils/screen_sizes.dart';

class DayNumber extends StatelessWidget {
  const DayNumber({
    required this.day,
    this.dateStyle,
  });

  final int day;
  final TextStyle? dateStyle;

  @override
  Widget build(BuildContext context) {
    final double size = getDayNumberSize(context);

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: Text(
        day > 0 ? day.toString() : '',
        textAlign: TextAlign.center,
        style: dateStyle ?? TextStyle(fontSize: 16),
      ),
    );
  }
}
