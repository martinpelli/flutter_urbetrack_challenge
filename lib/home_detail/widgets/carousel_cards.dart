import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletons/skeletons.dart';

class CarouselCards extends StatelessWidget {
  final String titleText;
  final List<String> texts;
  final IconData iconData;
  final bool isLoading;

  const CarouselCards({
    Key? key,
    required this.titlesStyle,
    required this.titleText,
    required this.texts,
    required this.iconData,
    required this.isLoading,
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
                        margin: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        width: 120,
                        child: isLoading
                            ? SkeletonLine(
                                style: SkeletonLineStyle(height: 80, width: 120, borderRadius: BorderRadius.circular(20)),
                              )
                            : Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height: 70,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                                        decoration: BoxDecoration(color: const Color(0xff273037), borderRadius: BorderRadius.circular(20)),
                                        child: Text(
                                          texts[index],
                                          style: const TextStyle(fontSize: 14),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
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
