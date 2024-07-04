// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_test_app/widgets/block_button.dart';
import 'package:flutter_test_app/widgets/level_card.dart';
import 'package:flutter_test_app/widgets/mood_card.dart';
import 'package:flutter_test_app/widgets/text_area.dart';
import 'package:provider/provider.dart';

import '../services/assets_path_converter.dart';

class MoodDairy extends StatefulWidget {
  const MoodDairy({super.key});

  @override
  State<MoodDairy> createState() => _MoodDairyState();
}

class _MoodDairyState extends State<MoodDairy> {
  int? selectedCard;
  TextEditingController textEditingController =TextEditingController();
  bool isStressLevelSet=false;
  bool isSelfAssessmentLevelSet=false;
  double stressLevel=6.0;
  double selfAssessmentLevel=6.0;
  int? selectedBlock;
  void cardClicked(int card){
    setState(() {
      selectedCard = card;
      selectedBlock=null; 
         });
  }
  void blockClicked(int block){
      setState(() {
        selectedBlock = block;
      });
  }
  @override
  Widget build(BuildContext context) {
     final pathConverter = Provider.of<AssetsPathConverter>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Что чувствуешь?", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 10,),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  MoodCard(imageAsset:pathConverter.definaPath("happy.png"),text:"Радость", onClick: () { cardClicked(1); }, isSelected: (selectedCard==1)?true:false,),
                  MoodCard(imageAsset:pathConverter.definaPath("fear.png"),text:"Страх", onClick: () {cardClicked(2);  },isSelected: (selectedCard==2)?true:false,),
                  MoodCard(imageAsset:pathConverter.definaPath("anger.png"),text:"Бешенство", onClick: () { cardClicked(3); },isSelected: (selectedCard==3)?true:false,),
                  MoodCard(imageAsset:pathConverter.definaPath("sad.png"),text:"Грусть", onClick: () { cardClicked(4); },isSelected: (selectedCard==4)?true:false,),
                  MoodCard(imageAsset:pathConverter.definaPath("calm.png"),text:"Спокойствие", onClick: () { cardClicked(5); },isSelected: (selectedCard==5)?true:false,),
                  MoodCard(imageAsset:pathConverter.definaPath("strong.png"),text:"Сила", onClick: () { cardClicked(6); }, isSelected: (selectedCard==6)?true:false,),
                ],
              ),
            ),
            SizedBox(height: 5,),
           if(selectedCard!=null&&selectedCard==1) Wrap(
            spacing: 6.0,
            runSpacing: 2.0,
              children: [
                BlockButton(blockNumber: 1, onClick:()=> blockClicked(1), text: "Возбуждение", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 2, onClick:()=> blockClicked(2), text: "Восторг", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 3, onClick:()=> blockClicked(3), text: "Игривость", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 4, onClick:()=> blockClicked(4), text: "Наслаждение", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 5, onClick:()=> blockClicked(5), text: "Очарование", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 6, onClick:()=> blockClicked(6), text: "Осознанность", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 7, onClick:()=> blockClicked(7), text: "Смелость", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 8, onClick:()=> blockClicked(8), text: "Удовольствие", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 9, onClick:()=> blockClicked(9), text: "Чувственность", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 10, onClick:()=> blockClicked(10), text: "Энергичность", selecteBlock: selectedBlock),
                BlockButton(blockNumber: 11, onClick:()=> blockClicked(11), text: "Экстравагантность", selecteBlock: selectedBlock),
              ],
            ),
            SizedBox(height: 10,),
            Text("Уровень стресса", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 15,),
            LevelCard(rightText: "Высокий", leftText: "Низкий", onClick: (double value){
              setState(() {
                isStressLevelSet=true;
                stressLevel=value;
              });
            }, isSet: isStressLevelSet, currentValue: stressLevel,),
            SizedBox(height: 25,),
            Text("Самооценка", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 15,),
            LevelCard(rightText: "Уверенность", leftText: "Неуверенность", onClick: (double value){
              setState(() {
                isSelfAssessmentLevelSet=true;
                selfAssessmentLevel=value;
              });
            }, isSet: isSelfAssessmentLevelSet, currentValue: selfAssessmentLevel,),
             SizedBox(height: 25,),
            Text("Заметки", style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 18),),
            SizedBox(height: 15,),
            TextAreaCard(textEditingController: textEditingController,
            onChanged: () {
              setState(() {
                debugPrint("dd");
              });
            },),
            SizedBox(height: 15,),
            Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.7, child: 
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    )
  ),
                backgroundColor: WidgetStatePropertyAll((selectedCard!=null&&textEditingController.text.isNotEmpty&&isSelfAssessmentLevelSet&&isStressLevelSet)? Theme.of(context).primaryColor:Theme.of(context).colorScheme.onSecondary),
              ),
              onPressed: (){
                if((selectedCard!=null&&textEditingController.text.isNotEmpty&&isSelfAssessmentLevelSet&&isStressLevelSet)){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Все результаты успешно записаны")));
                  setState(() {
                    selectedCard=null;
                    textEditingController.clear();
                    stressLevel=6.0;
                    selfAssessmentLevel=6.0;
                    isSelfAssessmentLevelSet=false;
                    isStressLevelSet=false;
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Все поля обязятельны")));
                }
              }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Сохранить", style: TextStyle(color:(selectedCard!=null&&textEditingController.text.isNotEmpty&&isSelfAssessmentLevelSet&&isStressLevelSet)? Colors.white:Theme.of(context).colorScheme.secondary),),
            ))))
          ],
        ),
      ),
    );
  }
}