// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class MonthConverter{
  String convertMonth(int month){
   switch (month) {
     case 1:
     return "Января";
     case 2:
     return "Февраля";
     case 3:
     return "Марта";
     case 4:
     return "Апреля";
     case 5:
     return "Мая";
     case 6:
     return "Июня";
     case 7:
     return "Июня";
     case 8:
     return "Августа";
     case 9:
     return "Сентября";
     case 10:
     return "Октября";
     case 11:
     return "Ноября";
     case 12:
     return "Декабря";
     default:
     return "undefined";
   }
}
}