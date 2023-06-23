// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SpecialButton extends StatefulWidget {
  final Color borderColor;
  final Color bodyColor;
  final String text;
  Function() onTap;
  final double height;
  final double width;
  final double textSize;
  final double borderRadius;
  final FontWeight fontWeight;
  final double borderwidth;
  final EdgeInsets padding;
  final EdgeInsets margin;
  SpecialButton({
    Key? key,
    required this.borderColor,
    required this.bodyColor,
    required this.text,
    required this.onTap,
    this.height = 40.0,
    this.width = 100.0,
    this.textSize = 14.0,
    this.borderRadius = 4.0,
    this.fontWeight = FontWeight.bold,
    this.borderwidth = 2.0,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  State<SpecialButton> createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: _isHovering ? widget.borderColor : widget.bodyColor,
          border:
              Border.all(color: widget.borderColor, width: widget.borderwidth),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: widget.textSize,
                color: _isHovering ? widget.bodyColor : widget.borderColor,
                fontWeight: widget.fontWeight),
          ),
        ),
      ),
    );
  }
}
