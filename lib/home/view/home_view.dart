import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home/bloc/home_bloc.dart';
import 'package:flutter_urbetrack_challenge/home/widgets/character_card.dart';
import 'package:flutter_urbetrack_challenge/home/widgets/rounded_grey_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _SearchField(),
          SizedBox(height: 18.0),
          _Body(),
        ],
      ),
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
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current.isSearching != previous.isSearching,
      builder: (context, state) => Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          keyboardType: TextInputType.name,
          autofocus: false,
          onSubmitted: (value) => BlocProvider.of<HomeBloc>(context).add(SearchCharacterEvent(text: controller.text)),
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.search, size: 30, color: const Color(0xff273037).withOpacity(0.7)),
              ),
              suffixIcon: state.isSearching
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        BlocProvider.of<HomeBloc>(context).add(SearchCharacterEvent(text: controller.text));
                      },
                      icon: Icon(Icons.clear, color: const Color(0xff273037).withOpacity(0.7)))
                  : null,
              labelText: "Buscar personajes"),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({
    Key? key,
  }) : super(key: key);

  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final characterCards = [
      CharacterCard(
        name: "Obi Wan Kenobi",
        gender: "Male",
      ),
      CharacterCard(
        name: "Obi Wan Kenobi",
        gender: "Male",
      ),
      CharacterCard(
        name: "Obi Wan Kenobi",
        gender: "Male",
      ),
      CharacterCard(
        name: "Obi Wan Kenobi",
        gender: "Male",
      ),
      CharacterCard(
        name: "Obi Wan Kenobi",
        gender: "Male",
      ),
    ];

    final double characterListHeight = MediaQuery.of(context).size.height - 325.0;
    final int amountOfCharactersCardToShow = (characterListHeight / 100.0).floor();
    final int amountOfPages = (characterCards.length / amountOfCharactersCardToShow).ceil();
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff11181E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
      ),
      height: screenHeight * 0.70,
      child: Column(
        children: [
          const _Title(),
          _ListNavigation(amountOfPages: amountOfPages, controller: controller),
          _CharacterList(
              amountOfPages: amountOfPages,
              amountOfCardsToShow: amountOfCharactersCardToShow,
              characterCards: characterCards,
              controller: controller),
        ],
      ),
    );
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
  final int amountOfPages;
  final PageController controller;

  const _ListNavigation({Key? key, required this.amountOfPages, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: SizedBox(
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RoundedGreyContianer(
              child: IconButton(
                  constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40, minHeight: 35, minWidth: 35),
                  onPressed: amountOfPages <= 1
                      ? null
                      : () {
                          (homeBloc.state.currentPage - 1) <= 0
                              ? controller.animateToPage(amountOfPages - 1, duration: const Duration(milliseconds: 200), curve: Curves.easeIn)
                              : controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                          homeBloc.add(PreviousPageEvent(amountOfPages: amountOfPages));
                        },
                  iconSize: 12,
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => previous.currentPage != current.currentPage,
              builder: (context, state) => RoundedGreyContianer(
                  child: Text('${state.currentPage}/$amountOfPages',
                      style: const TextStyle(color: Color(0xffE9B042), fontSize: 12.0, letterSpacing: 1.0))),
            ),
            RoundedGreyContianer(
              child: IconButton(
                  constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40, minHeight: 35, minWidth: 35),
                  onPressed: amountOfPages <= 1
                      ? null
                      : () {
                          (homeBloc.state.currentPage + 1) > amountOfPages
                              ? controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.easeIn)
                              : controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                          homeBloc.add(NextPageEvent(amountOfPages: amountOfPages));
                        },
                  iconSize: 12,
                  alignment: Alignment.center,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterList extends StatelessWidget {
  final int amountOfPages;
  final int amountOfCardsToShow;
  final List<CharacterCard> characterCards;
  final PageController controller;

  const _CharacterList({
    Key? key,
    required this.amountOfPages,
    required this.amountOfCardsToShow,
    required this.characterCards,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          itemCount: amountOfPages,
          itemBuilder: (_, pageIndex) => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: amountOfCardsToShow,
              itemBuilder: ((_, cardIndex) {
                final int arrayIndex = (amountOfCardsToShow * pageIndex) + cardIndex;
                if (arrayIndex < characterCards.length) {
                  return characterCards[arrayIndex];
                } else {
                  return Container();
                }
              }),
              separatorBuilder: (_, __) => const SizedBox(height: 8.0))),
    );
  }
}
