import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _TopBar(),
      bottomNavigationBar: _BottomBar(),
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
