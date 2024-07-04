// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_test_app/services/month_converter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
  final monthConverter = Provider.of<MonthConverter>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context, _selectedDay);
                }, icon: Icon(_selectedDay==null? Icons.clear_rounded:Icons.check, color: Theme.of(context).colorScheme.secondary), ),
                GestureDetector(
                  onTap:()=> Navigator.pop(context, DateTime.now()),
                  child: Text("Сегодня", style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.secondary),)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  final DateTime firstDayOfMonth = DateTime(DateTime.now().year, index + 1, 1);
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  '${firstDayOfMonth.year}',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  monthConverter.convertMonth(firstDayOfMonth.month),
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onSurface),
                                ),
                              )
                            ],
                          ),
                        ),
                        TableCalendar(
                          firstDay: firstDayOfMonth,
                          lastDay: DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0),
                          focusedDay: firstDayOfMonth,
                          headerVisible: false,
                          calendarFormat: CalendarFormat.month,
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 179, 0).withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                          ),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
