import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String titleText;
  final String text;
  final TextStyle titlesStyle;

  const InfoItem({
    Key? key,
    required this.titlesStyle,
    required this.titleText,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [Text(titleText, style: titlesStyle), const SizedBox(width: 20), Text(text, style: const TextStyle(fontSize: 15))],
      ),
    );
  }
}
