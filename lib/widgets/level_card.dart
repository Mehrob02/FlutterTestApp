// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test_app/services/assets_path_converter.dart';
import 'package:provider/provider.dart';

class LevelCard extends StatefulWidget {
  const LevelCard({super.key, required this.rightText, required this.leftText, required this.onClick, required this.isSet, required this.currentValue});
  final String rightText;
  final String leftText;
  final Function (double value) onClick;
  final bool isSet;
  final  double currentValue;
  @override
  State<LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<LevelCard> {
  double currentValue = 0;
  @override
  void initState() {
    currentValue= widget.isSet? widget.currentValue: 6.0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pathConverter = Provider.of<AssetsPathConverter>(context);
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(-1, 4),
            )
          ],
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(pathConverter.definaPath("rect.svg")),
                    SvgPicture.asset(pathConverter.definaPath("rect.svg")),
                    SvgPicture.asset(pathConverter.definaPath("rect.svg")),
                    SvgPicture.asset(pathConverter.definaPath("rect.svg")),
                    SvgPicture.asset(pathConverter.definaPath("rect.svg")),
                    SvgPicture.asset(pathConverter.definaPath("rect.svg")),
                  ],
                ),
              ),
              Stack(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 6.0,
                    ),
                    child: Slider(
                      thumbColor: widget.isSet?Theme.of(context).primaryColor:Theme.of(context).colorScheme.onSecondary,
                      activeColor: widget.isSet?Theme.of(context).primaryColor:Theme.of(context).colorScheme.onSecondary,
                      overlayColor: WidgetStatePropertyAll(Colors.white),
                      inactiveColor: Theme.of(context).colorScheme.onSecondary, 
                      secondaryActiveColor: Colors.green,
                      value: widget.currentValue,
                    min: 0,
                    max: 12,
                     onChanged:(value) {
                      setState(() {
                        currentValue=value;
                      });
                      widget.onClick(currentValue);
                    },),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.leftText, style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                    Text(widget.rightText, style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
                  ],
                ),
              ),
            ],
          ),
        ),
        )
          );
  }
}