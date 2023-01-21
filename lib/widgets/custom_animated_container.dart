import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/widgets/custom_animated_opacity.dart';

import '../home_list/bloc/home_list_bloc.dart';

class CustomAnimatedContainer extends StatefulWidget {
  final Widget child;
  final double? defaultHeight;

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
  Animation? _animation;
  double? _initHeight;
  double? _finalHeight;

  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    final double? heightFromOtherWidget = BlocProvider.of<HomeListBloc>(context, listen: false).previousHeight;

    if (widget.defaultHeight != null) {
      _initHeight = heightFromOtherWidget;
      _finalHeight = widget.defaultHeight!;
      _animation = Tween(begin: _initHeight, end: _finalHeight).animate(CurvedAnimation(parent: _animController, curve: Curves.fastOutSlowIn));
      _animController.forward();
      BlocProvider.of<HomeListBloc>(context).previousHeight = _finalHeight;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _getContainerHeigth(context);
      });
    }

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
        builder: (context, child) {
          if (_animation != null) {}
          return Container(
              key: _containerKey,
              decoration: const BoxDecoration(
                color: Color(0xff11181E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              height: (_animation != null) ? _animation!.value : MediaQuery.of(context).size.height - 240,
              child: child);
        });
  }

  void _getContainerHeigth(BuildContext context) {
    final RenderBox renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;

    final double height = renderBox.size.height;

    BlocProvider.of<HomeListBloc>(context).previousHeight = height;
    BlocProvider.of<HomeListBloc>(context).listContainerHeight = height;
  }
}
