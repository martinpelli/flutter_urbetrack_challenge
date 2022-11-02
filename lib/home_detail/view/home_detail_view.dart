import 'package:flutter/material.dart';
import 'package:flutter_urbetrack_challenge/home_detail/widgets/carousel_cards.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/info_item.dart';

class HomeDetailView extends StatelessWidget {
  final String character;

  const HomeDetailView({Key? key, required this.character}) : super(key: key);

  final titlesStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xff11181E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TitleName(name: character),
            _Details(titlesStyle: titlesStyle),
          ],
        ),
      ),
    );
  }
}

class _TitleName extends StatelessWidget {
  final String name;

  const _TitleName({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        alignment: Alignment.center,
        child: Text(name, style: const TextStyle(fontFamily: 'StarJedi', fontSize: 17.0, letterSpacing: 1.0)));
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key,
    required this.titlesStyle,
  }) : super(key: key);

  final TextStyle titlesStyle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          InfoItem(titleText: "Nacimiento", text: "20-20-2000", titlesStyle: titlesStyle),
          InfoItem(titleText: "Género", text: "Male", titlesStyle: titlesStyle),
          InfoItem(titleText: "Mundo Natal", text: "Tatooine", titlesStyle: titlesStyle),
          InfoItem(titleText: "Altura", text: "1.85", titlesStyle: titlesStyle),
          InfoItem(titleText: "Peso", text: "90", titlesStyle: titlesStyle),
          InfoItem(titleText: "Color de Pelo", text: "Magenta", titlesStyle: titlesStyle),
          InfoItem(titleText: "Color de Ojos", text: "Azul", titlesStyle: titlesStyle),
          CarouselCards(
              titleText: "Vehículos",
              texts: ["wooki", "asdsadd", "sadaas", "asdsdasdasd"],
              iconData: FontAwesomeIcons.truckMoving,
              titlesStyle: titlesStyle),
          CarouselCards(
              titleText: "Naves", texts: ["wooki", "asdsadd", "sadaas", "asdsdasdasd"], iconData: FontAwesomeIcons.rocket, titlesStyle: titlesStyle),
          const SizedBox(
            height: 20,
          ),
          const _ReportButton(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class _ReportButton extends StatelessWidget {
  const _ReportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () {}, child: Text("Reportar Avistamiento")));
  }
}
