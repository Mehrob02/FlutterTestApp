import 'package:flutter/material.dart';

class BlockButton extends StatefulWidget {
  const BlockButton({super.key, required this.blockNumber, required this.onClick, required this.text, required this.selecteBlock});
  final int blockNumber;
  final int? selecteBlock;
  final VoidCallback onClick;
  final String text;
  @override
  State<BlockButton> createState() => _BlockButtonState();
}

class _BlockButtonState extends State<BlockButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                 widget.selecteBlock==widget.blockNumber? Theme.of(context).primaryColor:Colors.white,
                  ),
              ), onPressed: (){setState(() {
                widget.onClick();
              });}, child: Text(widget.text, style: TextStyle(color: widget.selecteBlock==widget.blockNumber?Colors.white:Colors.black),));
  }
}