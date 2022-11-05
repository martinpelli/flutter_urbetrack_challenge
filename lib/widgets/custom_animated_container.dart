import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/widgets/custom_animated_opacity.dart';

import '../home_list/bloc/home_list_bloc.dart';

class CustomAnimatedContainer extends StatefulWidget {
  final Widget child;
  final double defaultHeight;

  const CustomAnimatedContainer({
    Key? key,
    required this.child,
    required this.defaultHeight,
  }) : super(key: key);

  @override
  State<CustomAnimatedContainer> createState() => CustomAnimatedContainerState();
}

class CustomAnimatedContainerState extends State<CustomAnimatedContainer> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation _animation;
  late final double _initHeight;
  late final double _finalHeight;

  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    final double? heightFromOtherWidget = BlocProvider.of<HomeListBloc>(context, listen: false).previousHeight;

    _initHeight = (heightFromOtherWidget == null) ? widget.defaultHeight : heightFromOtherWidget;
    _finalHeight = widget.defaultHeight;
    _animation = Tween(begin: _initHeight, end: _finalHeight).animate(CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));

    _animController.forward();

    BlocProvider.of<HomeListBloc>(context).previousHeight = _finalHeight;

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
        child: CustomAnimatedOpacity(child: widget.child),
        builder: (context, child) => Container(
            key: _containerKey,
            decoration: const BoxDecoration(
              color: Color(0xff11181E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            ),
            height: _animation.value,
            child: child));
  }
}
