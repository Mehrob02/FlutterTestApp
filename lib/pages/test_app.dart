// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/pages/date_picker.dart';
import 'package:flutter_test_app/pages/mood_dairy.dart';
import 'package:flutter_test_app/pages/statistics.dart';
import 'package:flutter_test_app/services/assets_path_converter.dart';
import 'package:flutter_test_app/services/month_converter.dart';
import 'package:provider/provider.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final PageController pageController = PageController();
  bool isSwitcherClicked=false;
  DateTime dateTime = DateTime.now();
  Future <void> datePicker(BuildContext context)async{
  DateTime? pickedDate = await Navigator.push(context, MaterialPageRoute(builder:(context) => DatePicker(),));
  debugPrint(pickedDate.toString());
  if(pickedDate!=null){
    setState(() {
      dateTime = pickedDate;
    });
  }
}
  
  @override
  Widget build(BuildContext context) {
    final monthConverter = Provider.of<MonthConverter>(context);
     final pathConverter = Provider.of<AssetsPathConverter>(context);
    return SafeArea(
      child: 
    Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            //datetime
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                ),
                Text("${dateTime.day} ${monthConverter.convertMonth(dateTime.month)} ${dateTime.hour}:00", style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary),),
                IconButton(onPressed: (){datePicker(context);}, icon: Icon(Icons.calendar_month_rounded, color: Theme.of(context).colorScheme.secondary,))
              ],
            ),
            //switcher
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).colorScheme.onSecondary
                    ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: GestureDetector(
                            onTap: (){
                              debugPrint("Dairy");
                              pageController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.linear);
                              setState(() {
                                isSwitcherClicked=false;
                                
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SvgPicture.asset(pathConverter.definaPath("Icons.svg"), fit: BoxFit.contain,),
                                ),
                                Text("Дневник настроения", style: TextStyle(color: Colors.white),),
                              ],
                            )
                            ),
                         ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                              debugPrint("Statistics");
                              pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.linear);
                              setState(() {
                                isSwitcherClicked=true;
                              });
                            },
                              child: Row(
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SvgPicture.asset(pathConverter.definaPath("Icons_statistics.svg"), fit: BoxFit.contain, color: Colors.white,),
                                ),
                                  Text("Statistics",style: TextStyle(color: Colors.white),),
                                ],
                              )),
                          ),
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      right: isSwitcherClicked? 0:null,
                      left: isSwitcherClicked?null:0,
                      duration: Duration(seconds: 2),
                      onEnd: (){
                      },
                      child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:!isSwitcherClicked?
                      Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SvgPicture.asset(pathConverter.definaPath("Icons.svg") , fit: BoxFit.contain,),
                                ),
                                Text("Дневник настроения",style: TextStyle(color: Colors.white),),
                              ],
                            ):
                    Row(
                                children: [
                                  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: SvgPicture.asset(pathConverter.definaPath("Icons_statistics.svg"), fit: BoxFit.contain, color: Colors.white,),
                                ),
                                  Text("Statistics",style: TextStyle(color: Colors.white),),
                                ],
                              )
                    )
                    )
                    )
                  ],
                )
              ],
            ),
            //content
            Expanded(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
               children: [
                MoodDairy(),
                Statistics()
               ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}