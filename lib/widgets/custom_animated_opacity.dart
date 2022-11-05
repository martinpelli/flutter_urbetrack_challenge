import 'package:flutter/material.dart';

class CustomAnimatedOpacity extends StatefulWidget {
  final Widget child;

  const CustomAnimatedOpacity({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomAnimatedOpacity> createState() => _CustomAnimatedOpacityState();
}

class _CustomAnimatedOpacityState extends State<CustomAnimatedOpacity> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _opacity;

  @override
  void initState() {
    _animController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Opacity(opacity: _opacity.value, child: child);
      },
    );
  }
}
