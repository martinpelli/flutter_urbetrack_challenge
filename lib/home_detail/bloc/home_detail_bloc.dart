import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_detail_event.dart';
part 'home_detail_state.dart';

class HomeDetailBloc extends Bloc<HomeDetailEvent, HomeDetailState> {
  HomeDetailBloc() : super(HomeDetailInitialState());
}
