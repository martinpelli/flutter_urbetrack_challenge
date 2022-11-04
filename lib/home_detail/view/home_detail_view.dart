import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_detail/bloc/home_detail_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_detail/widgets/carousel_cards.dart';
import 'package:flutter_urbetrack_challenge/main/bloc/main_bloc.dart';
import 'package:flutter_urbetrack_challenge/models/character/character_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/info_item.dart';

class HomeDetailView extends StatelessWidget {
  final Character character;
  final int characterId;

  const HomeDetailView({Key? key, required this.character, required this.characterId}) : super(key: key);

  final titlesStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    final HomeDetailBloc homeDetailBloc = BlocProvider.of<HomeDetailBloc>(context);
    homeDetailBloc.add(GetHomeworldEvent(homeWorld: character.homeworld));
    homeDetailBloc.add(GetVehiclesEvent(vehicles: character.vehicles));
    homeDetailBloc.add(GetStarshipsEvent(starships: character.starships));

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
            _TitleName(name: character.name),
            _Details(characterId: characterId, character: character, titlesStyle: titlesStyle),
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
  final Character character;
  final int characterId;

  const _Details({
    Key? key,
    required this.titlesStyle,
    required this.character,
    required this.characterId,
  }) : super(key: key);

  final TextStyle titlesStyle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: BlocConsumer<HomeDetailBloc, HomeDetailState>(
        listenWhen: (previous, current) => previous.snackBarMessage != current.snackBarMessage && current.snackBarMessage.isNotEmpty,
        listener: (context, state) => ScaffoldMessenger.of(context).showSnackBar(customSnackbar(state.snackBarMessage)),
        builder: (context, state) => ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            InfoItem(titleText: "Nacimiento:", text: character.birth_year, titlesStyle: titlesStyle),
            InfoItem(titleText: "Género:", text: character.gender, titlesStyle: titlesStyle),
            InfoItem(
              titleText: "Mundo Natal:",
              text: state.homeworld == null ? character.homeworld : state.homeworld!.name,
              titlesStyle: titlesStyle,
              isLoading: state.homeworld == null,
            ),
            InfoItem(titleText: "Altura:", text: character.height, titlesStyle: titlesStyle),
            InfoItem(titleText: "Peso:", text: character.mass, titlesStyle: titlesStyle),
            InfoItem(titleText: "Color de Pelo:", text: character.hair_color, titlesStyle: titlesStyle),
            InfoItem(titleText: "Color de Ojos:", text: character.eye_color, titlesStyle: titlesStyle),
            if (character.vehicles.isNotEmpty) ...[
              CarouselCards(
                titleText: "Vehículos",
                texts: state.vehicles == null ? character.vehicles : state.vehicles!.map((v) => v.name).toList(),
                iconData: FontAwesomeIcons.truckMoving,
                titlesStyle: titlesStyle,
                isLoading: state.vehicles == null,
              )
            ],
            if (character.starships.isNotEmpty) ...[
              CarouselCards(
                  titleText: "Naves",
                  texts: state.starships == null ? character.starships : state.starships!.map((s) => s.name).toList(),
                  iconData: FontAwesomeIcons.rocket,
                  titlesStyle: titlesStyle,
                  isLoading: state.starships == null)
            ],
            const SizedBox(
              height: 20,
            ),
            _ReportButton(characterId: characterId, name: character.name, snackBarMessage: state.snackBarMessage),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  SnackBar customSnackbar(String message) {
    return SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xff273037),
        content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)));
  }
}

class _ReportButton extends StatelessWidget {
  final int characterId;
  final String name;
  final String snackBarMessage;

  const _ReportButton({
    Key? key,
    required this.characterId,
    required this.name,
    required this.snackBarMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) => MaterialButton(
                disabledColor: Colors.grey,
                color: const Color(0xffE9B042),
                onPressed: state.isEnabled && snackBarMessage != "Enviando reporte"
                    ? () => BlocProvider.of<HomeDetailBloc>(context).add(ReportSightingEvent(userId: characterId, name: name))
                    : null,
                child: const Text("Reportar Avistamiento"))));
  }
}
