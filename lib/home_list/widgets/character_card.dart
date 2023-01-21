import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_list/bloc/home_list_bloc.dart';
import 'package:flutter_urbetrack_challenge/models/character/character_model.dart';
import 'package:flutter_urbetrack_challenge/navigation/bloc/navigation_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CharacterCard extends StatelessWidget {
  final int index;
  final Character character;

  const CharacterCard({Key? key, required this.character, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
          onTap: () {
            BlocProvider.of<NavigationBloc>(context).add(GoToHomeDetailEvent(characterId: index, character: character));
            BlocProvider.of<HomeListBloc>(context).removeController();
          },
          leading: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: FaIcon(
                FontAwesomeIcons.jedi,
                size: 30,
              )),
          title: Text(
            character.name,
            style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(character.gender),
          trailing: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.arrow_forward_ios, size: 20),
          ),
        ),
      ),
    );
  }
}
