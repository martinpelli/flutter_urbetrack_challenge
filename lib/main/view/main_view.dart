import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/main/bloc/main_bloc.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 30),
      decoration: _buildBoxdecoration(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(
              isEnabled: state.isEnabled,
            ),
            const SizedBox(width: 20),
            _Switch(
              isEnabled: state.isEnabled,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxdecoration() {
    return const BoxDecoration(
        gradient: RadialGradient(
      radius: 0.85,
      colors: [Color(0xff273037), Color.fromARGB(255, 31, 38, 44)],
    ));
  }
}

class _Title extends StatelessWidget {
  final bool isEnabled;

  const _Title({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        isEnabled ? "Desactivar Conexión" : "Activar Conexión",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }
}

class _Switch extends StatelessWidget {
  final bool isEnabled;

  const _Switch({
    Key? key,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Switch(
          inactiveThumbColor: const Color(0xff78828B).withOpacity(0.7),
          inactiveTrackColor: const Color(0xff78828B),
          value: isEnabled,
          onChanged: (value) => BlocProvider.of<MainBloc>(context).add(ChangeConnectionEvent(value: value))),
    );
  }
}
