library scrolling_years_calendar;

import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/utils/screen_sizes.dart';
import 'package:scrolling_years_calendar/year_view.dart';

class ScrollingYearsCalendar extends StatefulWidget {
  ScrollingYearsCalendar({
    required this.context,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.currentDateColor,
    required this.onMonthTap,
    required this.monthTitleStyle,
    this.highlightedDates,
    this.dateStyle,
    this.currentDateStyle,
    this.highlightedDateStyle,
  })  : assert(!initialDate.isBefore(firstDate),
            'initialDate must be on or after firstDate'),
        assert(!initialDate.isAfter(lastDate),
            'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate),
            'lastDate must be on or after firstDate');

  final BuildContext context;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color currentDateColor;
  final List<DateTime>? highlightedDates;
  final Function onMonthTap;
  final TextStyle monthTitleStyle;
  final TextStyle? dateStyle;
  final TextStyle? currentDateStyle;
  final TextStyle? highlightedDateStyle;

  @override
  _ScrollingYearsCalendarState createState() => _ScrollingYearsCalendarState();
}

class _ScrollingYearsCalendarState extends State<ScrollingYearsCalendar> {
  /// Gets a widget with the view of the given year.
  YearView _getYearView(int year) {
    return YearView(
      context: context,
      year: year,
      highlightedDates: widget.highlightedDates,
      onMonthTap: widget.onMonthTap,
      monthTitleStyle: widget.monthTitleStyle,
      currentDateStyle: widget.currentDateStyle,
      dateStyle: widget.dateStyle,
      highlightedDateStyle: widget.highlightedDateStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int _itemCount = widget.lastDate.year - widget.firstDate.year + 1;

    // Makes sure the right initial offset is calculated so the list view
    // jumps to the initial year.
    final double _initialOffset =
        (widget.initialDate.year - widget.firstDate.year) *
            getYearViewHeight(context);
    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: _initialOffset);

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16.0),
      controller: _scrollController,
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index) {
        final int year = index + widget.firstDate.year;
        return _getYearView(year);
      },
    );
  }
}
