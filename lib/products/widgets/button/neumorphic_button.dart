import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    Key? key,
    required this.backgroundColor,
    required this.shadowColor,
    required this.onTap,
    required this.child,
    this.duration,
    this.borderRadius,
    this.height,
    this.width,
    this.curve,
  }) : super(key: key);

  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Widget child;
  final Curve? curve;
  final Duration? duration;
  final double? height;
  final VoidCallback onTap;
  final Color shadowColor;
  final double? width;

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  late final Duration _duration;
  bool _isElevated = true;

  @override
  void initState() {
    super.initState();
    _duration = widget.duration ?? const Duration(milliseconds: 100);
  }

  void _onTap() {
    widget.onTap();
    setState(() {
      _isElevated = !_isElevated;
    });
    Future.delayed(_duration).then((value) {
      setState(() {
        _isElevated = !_isElevated;
      });
    });
  }

  AnimatedContainer _buildAnimatedContainer() {
    return AnimatedContainer(
      curve: widget.curve ?? Curves.bounceInOut,
      duration: _duration,
      height: widget.height,
      width: widget.width,
      decoration: _buildBoxDecoration(),
      child: Opacity(
        opacity: _isElevated ? 1 : 0.7,
        child: widget.child,
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: _isElevated
            ? [
                _buildBoxShadow(4),
                _buildBoxShadow(-4),
              ]
            : null);
  }

  BoxShadow _buildBoxShadow(double offsetValue) {
    return BoxShadow(
      color: widget.shadowColor,
      offset: Offset(offsetValue, offsetValue),
      blurRadius: 16,
      spreadRadius: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: _buildAnimatedContainer(),
    );
  }
}
