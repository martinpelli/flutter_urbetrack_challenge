import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_list/bloc/home_list_bloc.dart';
import 'package:flutter_urbetrack_challenge/home_list/widgets/character_card.dart';
import 'package:flutter_urbetrack_challenge/home_list/widgets/character_card_loading.dart';
import 'package:flutter_urbetrack_challenge/home_list/widgets/rounded_grey_container.dart';
import 'package:flutter_urbetrack_challenge/widgets/custom_animated_container.dart';
import 'package:flutter_urbetrack_challenge/widgets/custom_animated_opacity.dart';

import '../../models/character/character_model.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: const [_Body(), _SearchField()],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = BlocProvider.of<HomeListBloc>(context).searchController;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: CustomAnimatedOpacity(
        child: BlocBuilder<HomeListBloc, HomeListState>(
          buildWhen: (previous, current) => current.isSearching != previous.isSearching,
          builder: (context, state) => Container(
            height: 60.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: searchController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.name,
              autofocus: false,
              onSubmitted: (_) => BlocProvider.of<HomeListBloc>(context).add(SearchCharacterEvent()),
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.search, size: 25, color: const Color(0xff273037).withOpacity(0.7)),
                  ),
                  suffixIcon: state.isSearching
                      ? IconButton(
                          onPressed: () {
                            searchController.clear();
                            BlocProvider.of<HomeListBloc>(context).add(SearchCharacterEvent());
                          },
                          icon: Icon(Icons.clear, color: const Color(0xff273037).withOpacity(0.7)))
                      : null,
                  labelText: "Buscar personaje..."),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double characterListHeight = MediaQuery.of(context).size.height - 225.0;
    final int amountOfCardsToShowPerPage = (characterListHeight / 110.0).floor();

    final listContainerHeight = BlocProvider.of<HomeListBloc>(context).listContainerHeight;

    return CustomAnimatedContainer(
      defaultHeight: listContainerHeight,
      child: Column(
        children: [
          const _Title(),
          _ListNavigation(amountOfCardsToShowPerPage: amountOfCardsToShowPerPage),
          _CharacterList(amountOfCardsToShowPerPage: amountOfCardsToShowPerPage),
          const SizedBox(height: 18.0)
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
      height: 70.0,
      padding: const EdgeInsets.only(top: 20.0),
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
      padding: const EdgeInsets.only(bottom: 18.0),
      child: SizedBox(
        height: 35,
        child: BlocBuilder<HomeListBloc, HomeListState>(
            buildWhen: (previous, current) =>
                previous.currentPage != current.currentPage ||
                (previous.isChangingPage != current.isChangingPage) ||
                previous.people == null ||
                current.people == null,
            builder: (context, state) {
              final int totalAmountOfPages =
                  state.people != null && state.people!.count > 0 ? (state.people!.count / amountOfCardsToShowPerPage).ceil() : 1;
              final int currentAmountOfPages =
                  state.people != null && state.people!.count > 0 ? (state.people!.results.length / amountOfCardsToShowPerPage).ceil() : 1;

              if (state.currentPage >= currentAmountOfPages && !state.isChangingPage && state.people != null) {
                BlocProvider.of<HomeListBloc>(context).add(GetPeopleEvent());
              }

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
                  controller: homeListBloc.pageController,
                  itemCount: totalAmountOfPages,
                  itemBuilder: (_, pageIndex) => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: amountOfCardsToShowPerPage,
                      itemBuilder: ((_, cardIndex) {
                        final int arrayIndex = (amountOfCardsToShowPerPage * pageIndex) + cardIndex;

                        if (arrayIndex >= characters.length) {
                          if (state.isLoading) return const CharacterCardLoading();
                          return Container();
                        }

                        return CharacterCard(index: arrayIndex, character: characters[arrayIndex]);
                      }),
                      separatorBuilder: (_, __) => const SizedBox(height: 10.0))),
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
