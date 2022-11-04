import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_list/bloc/home_list_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_list/widgets/character_card.dart';
import 'package:flutter_urbetrack_challenge/home_list/widgets/character_card_loading.dart';
import 'package:flutter_urbetrack_challenge/home_list/widgets/rounded_grey_container.dart';

import '../../models/character/character_model.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _SearchField(),
        const SizedBox(height: 18.0),
        _Body(),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  _SearchField({
    Key? key,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      buildWhen: (previous, current) => current.isSearching != previous.isSearching,
      builder: (context, state) => Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.name,
          autofocus: false,
          onSubmitted: (value) => BlocProvider.of<HomeListBloc>(context).add(SearchCharacterEvent(text: controller.text)),
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.search, size: 30, color: const Color(0xff273037).withOpacity(0.7)),
              ),
              suffixIcon: state.isSearching
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        BlocProvider.of<HomeListBloc>(context).add(SearchCharacterEvent(text: controller.text));
                      },
                      icon: Icon(Icons.clear, color: const Color(0xff273037).withOpacity(0.7)))
                  : null,
              labelText: "Buscar personaje..."),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double characterListHeight = MediaQuery.of(context).size.height - 325.0;

    final int amountOfCardsToShowPerPage = (characterListHeight / 100.0).floor();

    return Container(
        decoration: const BoxDecoration(
          color: Color(0xff11181E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
        ),
        height: screenHeight * 0.70,
        child: Column(
          children: [
            const _Title(),
            _ListNavigation(amountOfCardsToShowPerPage: amountOfCardsToShowPerPage),
            _CharacterList(amountOfCardsToShowPerPage: amountOfCardsToShowPerPage),
          ],
        ));
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: const Text("Personajes", style: TextStyle(fontFamily: 'StarJedi', fontSize: 17.0, letterSpacing: 1.0)),
    );
  }
}

class _ListNavigation extends StatelessWidget {
  final int amountOfCardsToShowPerPage;

  const _ListNavigation({Key? key, required this.amountOfCardsToShowPerPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeListBloc homeListBloc = BlocProvider.of<HomeListBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: SizedBox(
        height: 35,
        child: BlocBuilder<HomeListBloc, HomeListState>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage || (previous.isChangingPage != current.isChangingPage) || previous.people == null,
            builder: (context, state) {
              final int totalAmountOfPages = state.people != null ? (state.people!.count / amountOfCardsToShowPerPage).ceil() : 1;
              final int currentAmountOfPages = state.people != null ? (state.people!.results.length / amountOfCardsToShowPerPage).ceil() : 1;
              if (state.currentPage >= currentAmountOfPages && state.people != null) BlocProvider.of<HomeListBloc>(context).add(GetPeopleEvent());

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RoundedGreyContianer(
                    child: IconButton(
                        constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40, minHeight: 35, minWidth: 35),
                        onPressed: (totalAmountOfPages <= 1 ||
                                state.isChangingPage ||
                                (state.currentPage == 1 && state.people!.results.length != state.people!.count))
                            ? null
                            : () => homeListBloc.add(PreviousPageEvent(amountOfPages: totalAmountOfPages)),
                        iconSize: 12,
                        icon: const Icon(Icons.arrow_back_ios_new)),
                  ),
                  RoundedGreyContianer(
                      child: Text('${state.currentPage}/$totalAmountOfPages',
                          style: const TextStyle(color: Color(0xffE9B042), fontSize: 12.0, letterSpacing: 1.0))),
                  RoundedGreyContianer(
                    child: IconButton(
                        constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40, minHeight: 35, minWidth: 35),
                        onPressed: (totalAmountOfPages <= 1 || state.isChangingPage)
                            ? null
                            : () => homeListBloc.add(NextPageEvent(amountOfPages: totalAmountOfPages)),
                        iconSize: 12,
                        alignment: Alignment.center,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        )),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class _CharacterList extends StatelessWidget {
  final int amountOfCardsToShowPerPage;

  const _CharacterList({
    Key? key,
    required this.amountOfCardsToShowPerPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeListBloc homeListBloc = BlocProvider.of<HomeListBloc>(context);

    return BlocBuilder<HomeListBloc, HomeListState>(
        buildWhen: (previous, current) =>
            (current.people != null &&
                (previous.people == null || (previous.people != null && previous.people!.results.length < current.people!.results.length))) ||
            (previous.isLoading != current.isLoading),
        builder: (context, state) {
          final int totalAmountOfPages = state.people != null ? (state.people!.count / amountOfCardsToShowPerPage).ceil() : 1;
          final List<Character> characters = (state.people != null) ? state.people!.results : [];

          return Expanded(
            child: ScrollConfiguration(
              behavior: ScrollWithoutGlowBehavior(),
              child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: homeListBloc.controller,
                  itemCount: totalAmountOfPages,
                  itemBuilder: (_, pageIndex) => ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: amountOfCardsToShowPerPage,
                      itemBuilder: ((_, cardIndex) {
                        final int arrayIndex = (amountOfCardsToShowPerPage * pageIndex) + cardIndex;

                        if (arrayIndex >= characters.length) {
                          if (state.isLoading) return const CharacterCardLoading();
                          return Container();
                        }

                        return CharacterCard(character: characters[arrayIndex]);
                      }),
                      separatorBuilder: (_, __) => const SizedBox(height: 8.0))),
            ),
          );
        });
  }
}

class ScrollWithoutGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
