import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthTitle extends StatelessWidget {
  const MonthTitle({
    required this.month,
    this.style = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  });

  final int month;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final String monthName =
        DateFormat.MMMM(Localizations.localeOf(context).toString())
            .format(DateTime(0, month));

    return Container(
      child: Text(
        monthName,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    );
  }
}
