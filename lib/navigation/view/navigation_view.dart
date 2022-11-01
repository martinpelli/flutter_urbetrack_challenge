import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home/view/home_view.dart';
import 'package:flutter_urbetrack_challenge/navigation/bloc/navigation_bloc.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const _TopBar(),
        body: BlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
          switch (state.currentNavIndex) {
            default:
              return const HomeView();
          }
        }),
        bottomNavigationBar: const _BottomBar(),
      ),
    );
  }
}

class _TopBar extends StatelessWidget with PreferredSizeWidget {
  const _TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Star Wars',
        style: TextStyle(fontFamily: 'StarJedi', fontSize: 22.0, color: Color(0xffE9B042)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 55.0);
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: BottomNavigationBar(currentIndex: 0, items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'inicio',
            activeIcon: Icon(
              Icons.home,
            )),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'menu',
            activeIcon: Icon(
              Icons.menu,
            )),
      ]),
    );
  }
}
