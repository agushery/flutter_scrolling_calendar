import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/month_view.dart';
import 'package:scrolling_years_calendar/utils/screen_sizes.dart';
import 'package:scrolling_years_calendar/year_title.dart';

class YearView extends StatelessWidget {
  const YearView({
    required this.context,
    required this.year,
    required this.onMonthTap,
    required this.monthTitleStyle,
    this.highlightedDates,
    this.dateStyle,
    this.currentDateStyle,
    this.highlightedDateStyle,
  });

  final BuildContext context;
  final int year;
  final List<DateTime>? highlightedDates;
  final Function onMonthTap;
  final TextStyle monthTitleStyle;
  final TextStyle? dateStyle;
  final TextStyle? currentDateStyle;
  final TextStyle? highlightedDateStyle;

  double get horizontalMargin => 16.0;
  double get monthViewPadding => 8.0;

  Widget buildYearMonths(BuildContext context) {
    final List<Row> monthRows = <Row>[];
    final List<MonthView> monthRowChildren = <MonthView>[];

    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      monthRowChildren.add(
        MonthView(
          context: context,
          year: year,
          month: month,
          padding: monthViewPadding,
          currentDateStyle: currentDateStyle,
          highlightedDates: highlightedDates,
          highlightedDateStyle: highlightedDateStyle,
          onTap: onMonthTap,
          titleStyle: monthTitleStyle,
          dateStyle: dateStyle,
        ),
      );

      if (month % 3 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<MonthView>.of(monthRowChildren),
          ),
        );
        monthRowChildren.clear();
      }
    }

    return Column(
      children: List<Row>.of(monthRows),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getYearViewHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin,
              vertical: 0.0,
            ),
            child: YearTitle(year),
          ),
          Container(
            margin: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              top: 8.0,
            ),
            child: const Divider(color: Colors.black26),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: horizontalMargin - monthViewPadding,
              vertical: 0.0,
            ),
            child: buildYearMonths(context),
          ),
        ],
      ),
    );
  }
}
