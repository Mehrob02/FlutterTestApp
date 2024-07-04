// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/test_app.dart';
import 'package:flutter_test_app/services/month_converter.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          Provider<MonthConverter>(create: (_) => MonthConverter()),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          primaryColor: Color.fromARGB(255, 202, 116, 4),
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 202, 116, 4), secondary: Colors.grey, onSecondary: Colors.grey[350], onSurface: Color.fromARGB(228, 9, 17, 77)),),
      title: 'Flutter Demo',
      home: TestApp(),
      )
        ),)
    ;
}

