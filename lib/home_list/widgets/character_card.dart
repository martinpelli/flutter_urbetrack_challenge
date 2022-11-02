import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/navigation/bloc/navigation_bloc.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String gender;

  const CharacterCard({Key? key, required this.name, required this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      child: Material(
        type: MaterialType.transparency,
        child: ListTile(
          onTap: () => BlocProvider.of<NavigationBloc>(context).add(GoToHomeDetailEvent(character: name)),
          leading: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(gender),
          trailing: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.arrow_right_sharp, size: 20),
          ),
        ),
      ),
    );
  }
}
