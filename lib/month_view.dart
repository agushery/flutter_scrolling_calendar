import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/day_number.dart';
import 'package:scrolling_years_calendar/month_title.dart';
import 'package:scrolling_years_calendar/utils/dates.dart';
import 'package:scrolling_years_calendar/utils/screen_sizes.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    required this.context,
    required this.year,
    required this.month,
    required this.padding,
    required this.onTap,
    required this.titleStyle,
    this.dateStyle,
    this.highlightedDates,
    this.currentDateStyle,
    this.highlightedDateStyle,
  });

  final BuildContext context;
  final int year;
  final int month;
  final double padding;
  final List<DateTime>? highlightedDates;
  final Function onTap;
  final TextStyle titleStyle;
  final TextStyle? dateStyle;
  final TextStyle? currentDateStyle;
  final TextStyle? highlightedDateStyle;

  TextStyle? getDayNumberTextStyle(DateTime date) {
    if (isCurrentDate(date)) {
      return currentDateStyle;
    }
    if (isHighlightedDate(date, highlightedDates)) {
      return highlightedDateStyle;
    }
    return dateStyle;
  }

  Widget buildMonthDays(BuildContext context) {
    final List<Row> dayRows = <Row>[];
    final List<DayNumber> dayRowChildren = <DayNumber>[];

    final int daysInMonth = getDaysInMonth(year, month);
    final int firstWeekdayOfMonth = DateTime(year, month, 1).weekday;

    // Add empty DayNumber widgets for the days before the first day of the month
    for (int i = 1; i < firstWeekdayOfMonth; i++) {
      dayRowChildren.add(DayNumber(day: 0));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      dayRowChildren.add(DayNumber(
        day: day,
        dateStyle: getDayNumberTextStyle(
          DateTime(year, month, day),
        ),
      ));

      if ((dayRowChildren.length) % DateTime.daysPerWeek == 0 ||
          day == daysInMonth) {
        dayRows.add(Row(children: List<DayNumber>.of(dayRowChildren)));
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context) {
    return Container(
      width: 7 * getDayNumberSize(context),
      margin: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MonthTitle(
            month: month,
            style: titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: buildMonthDays(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(year, month),
      child: buildMonthView(context),
    );
  }
}
