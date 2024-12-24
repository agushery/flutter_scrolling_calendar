import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/scrolling_years_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrolling Years Calendar',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Scrolling Calendar'),
      ),
      body: Center(
        child: ScrollingYearsCalendar(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
          currentDateColor: Colors.blue,
          highlightedDates: generateHighlightedDates(),
          onMonthTap: (int year, int month) {
            print('Tapped on month: $month, year: $year');
          },
          monthTitleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          dateStyle: TextStyle(fontSize: 8),
          currentDateStyle: TextStyle(fontSize: 12, color: Colors.red),
          highlightedDateStyle: TextStyle(fontSize: 8, color: Colors.green),
        ),
      ),
    );
  }
}

List<DateTime> generateHighlightedDates() {
  final DateTime now = DateTime.now();
  final DateTime oneMonthBefore = DateTime(now.year, now.month - 1, now.day);
  final DateTime oneMonthAfter = DateTime(now.year, now.month + 1, now.day);

  List<DateTime> highlightedDates = [];
  DateTime currentDate = oneMonthBefore;

  while (currentDate.isBefore(oneMonthAfter) ||
      currentDate.isAtSameMomentAs(oneMonthAfter)) {
    highlightedDates.add(currentDate);
    currentDate = currentDate.add(Duration(days: 1));
  }

  return highlightedDates;
}
