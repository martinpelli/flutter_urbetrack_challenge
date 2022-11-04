import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CharacterCardLoading extends StatelessWidget {
  const CharacterCardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
      ),
      child: SkeletonLine(
        style: SkeletonLineStyle(width: double.infinity, height: 85, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
