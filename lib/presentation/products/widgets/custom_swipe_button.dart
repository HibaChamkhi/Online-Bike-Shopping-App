import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwipeButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onSwipe;

  const CustomSwipeButton({
    required this.child,
    required this.onSwipe,
    Key? key,
  }) : super(key: key);

  @override
  _CustomSwipeButtonState createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton> {
  double _dragValue = 0;
  double _buttonWidth = 200;
  double _thumbWidth = 50;
  Color _backgroundColor = const Color(0xFF242C3B);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragValue = (details.localPosition.dx).clamp(0.0, _buttonWidth - _thumbWidth);
          _backgroundColor = Color.lerp(
            const Color(0xFF020C2A),
            Color(0xFF4A8EFF),
            _dragValue / (_buttonWidth - _thumbWidth),
          )!;
        });
      },
      onHorizontalDragEnd: (details) {
        if (_dragValue > _buttonWidth * 0.8) {
          widget.onSwipe();
          setState(() {
            _dragValue = _buttonWidth - _thumbWidth;
            _backgroundColor = Color(0xFF242C3B);
          });
        } else {
          setState(() {
            _dragValue = 0;
            _backgroundColor = const Color(0xFF242C3B);
          });
        }
      },
      child: Container(
        width: _buttonWidth,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(-5, -3),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              left: _dragValue,
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: _thumbWidth,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF4A8EFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}