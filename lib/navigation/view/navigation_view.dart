import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_detail/bloc/home_detail_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_detail/view/home_detail_view.dart';
import 'package:flutter_urbetrack_challenge/home_list/view/home_list_view.dart';
import 'package:flutter_urbetrack_challenge/main/bloc/main_bloc.dart';
import 'package:flutter_urbetrack_challenge/main/view/main_view.dart';
import 'package:flutter_urbetrack_challenge/navigation/bloc/navigation_bloc.dart';

import '../../home_list/bloc/home_list_bloc.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => MainBloc()),
        BlocProvider(create: (_) => HomeListBloc()),
        BlocProvider(create: (_) => HomeDetailBloc()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const _TopBar(),
        body: BlocBuilder<NavigationBloc, NavigationState>(builder: (context, state) {
          switch (state.currentNavIndex) {
            case 1:
              return const MainView();
            default:
              if (state.character != null) {
                return HomeDetailView(
                  characterId: state.characterId!,
                  character: state.character!,
                );
              } else {
                return const HomeListView();
              }
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
    return BlocBuilder<NavigationBloc, NavigationState>(
      buildWhen: (previous, current) => (previous.character != current.character) || (previous.currentNavIndex != current.currentNavIndex),
      builder: (context, state) => AppBar(
        leading: (state.character != null && state.currentNavIndex == 0)
            ? IconButton(
                onPressed: () {
                  BlocProvider.of<NavigationBloc>(context).add(PopHomeDetailEvent());
                  BlocProvider.of<HomeListBloc>(context).add(RestorePageEvent());
                  BlocProvider.of<HomeDetailBloc>(context).add(ResetDetailsEvent());
                },
                icon: const Icon(Icons.arrow_back))
            : null,
        title: const Text(
          'Star Wars',
          style: TextStyle(fontFamily: 'StarJedi', fontSize: 22.0, color: Color(0xffE9B042)),
        ),
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
      child: BlocBuilder<NavigationBloc, NavigationState>(
        buildWhen: (previous, current) => previous.currentNavIndex != current.currentNavIndex,
        builder: (context, state) => BottomNavigationBar(
            currentIndex: state.currentNavIndex,
            onTap: (value) {
              if (value == 0) {
                BlocProvider.of<HomeListBloc>(context).add(RestorePageEvent());
              } else {
                BlocProvider.of<HomeListBloc>(context).add(RemoveControllerEvent());
              }
              BlocProvider.of<NavigationBloc>(context).add(ChangePageEvent(navIndex: value));
            },
            items: const [
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
      ),
    );
  }
}
