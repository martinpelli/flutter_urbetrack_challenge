import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarouselCards extends StatelessWidget {
  final String titleText;
  final List<String> texts;
  final IconData iconData;

  const CarouselCards({
    Key? key,
    required this.titlesStyle,
    required this.titleText,
    required this.texts,
    required this.iconData,
  }) : super(key: key);

  final TextStyle titlesStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleText, style: titlesStyle),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: texts.length,
                  itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        width: 120,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 70,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  decoration: BoxDecoration(color: const Color(0xff273037), borderRadius: BorderRadius.circular(20)),
                                  child: Text(texts[index], style: const TextStyle(fontSize: 15))),
                            ),
                            Positioned(
                              top: 5,
                              child: FaIcon(
                                iconData,
                                size: 60,
                                color: const Color(0xff78828B),
                              ),
                            )
                          ],
                        ),
                      )),
            )
          ],
        ));
  }
}
