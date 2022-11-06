part of 'home_list_bloc.dart';

class HomeListState {
  final int currentPage;
  final bool isSearching;
  final People? people;
  final bool isLoading;
  final bool isChangingPage;
  final int currentPeoplePage;
  final String searchText;

  HomeListState(
      {required this.currentPage,
      required this.isSearching,
      required this.people,
      required this.isLoading,
      required this.isChangingPage,
      required this.currentPeoplePage,
      required this.searchText});

  HomeListState copyWith(
          {int? currentPage, bool? isSearching, People? people, bool? isLoading, bool? isChangingPage, int? currentPeoplePage, String? searchText}) =>
      HomeListState(
          currentPage: currentPage ?? this.currentPage,
          isSearching: isSearching ?? this.isSearching,
          people: people ?? this.people,
          isLoading: isLoading ?? this.isLoading,
          isChangingPage: isChangingPage ?? this.isChangingPage,
          currentPeoplePage: currentPeoplePage ?? this.currentPeoplePage,
          searchText: searchText ?? this.searchText);

  factory HomeListState.fromJson(Map<String, dynamic> json) => HomeListState(
      currentPage: json['currentPage'] ?? 1,
      isSearching: json['isSearching'] ?? false,
      people: json['people'] != null ? People.fromJson(json['people']) : null,
      isLoading: json['isLoading'] ?? false,
      isChangingPage: json['isChangingPage'] ?? false,
      currentPeoplePage: json['currentPeoplePage'] ?? 0,
      searchText: json['searchText'] ?? '');

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "isSearching": isSearching,
        "people": people,
        "isLoading": isLoading,
        "isChangingPage": isChangingPage,
        "currentPeoplePage": currentPeoplePage,
        "searchText": searchText
      };
}

class HomeListInitialState extends HomeListState {
  HomeListInitialState()
      : super(currentPage: 1, isSearching: false, people: null, isLoading: false, isChangingPage: false, currentPeoplePage: 0, searchText: '');
}

class HomeListSearchingState extends HomeListState {
  final String text;
  HomeListSearchingState({required this.text})
      : super(currentPage: 1, isSearching: false, people: null, isLoading: true, isChangingPage: false, currentPeoplePage: 0, searchText: text);
}
