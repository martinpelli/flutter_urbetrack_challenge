import 'package:flutter/material.dart';

class RoundedGreyContianer extends StatelessWidget {
  final Widget child;

  const RoundedGreyContianer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        alignment: Alignment.center,
        height: double.infinity,
        decoration: BoxDecoration(color: const Color(0xff273037), borderRadius: BorderRadius.circular(20)),
        child: child);
  }
}
