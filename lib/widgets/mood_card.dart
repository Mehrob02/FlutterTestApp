import 'package:flutter/material.dart';

class MoodCard extends StatefulWidget {
  const MoodCard({super.key, required this.imageAsset, required this.text, required this.onClick, required this.isSelected});
  final String imageAsset;
  final String text;
  final VoidCallback onClick;
  final bool isSelected;
  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: widget.onClick,
        child: Container(
          width: MediaQuery.of(context).size.width*0.24,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(-1, 4),
              )
            ],
            shape: BoxShape.rectangle,
            border: widget.isSelected? Border.all(width: 3, color: Theme.of(context).primaryColor):Border.all( color: Colors.transparent),

          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(widget.imageAsset, fit: BoxFit.contain,),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(widget.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}