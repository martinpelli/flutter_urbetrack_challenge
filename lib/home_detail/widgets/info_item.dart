import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class InfoItem extends StatelessWidget {
  final String titleText;
  final String text;
  final TextStyle titlesStyle;
  final bool isLoading;

  const InfoItem({Key? key, required this.titlesStyle, required this.titleText, required this.text, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(titleText, style: titlesStyle),
          const SizedBox(width: 10),
          isLoading
              ? const SkeletonLine(style: SkeletonLineStyle(height: 15, width: 100))
              : Text(
                  text,
                  style: const TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                )
        ],
      ),
    );
  }
}
