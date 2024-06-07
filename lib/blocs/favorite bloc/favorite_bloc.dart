import 'dart:async';

import 'package:anime/data/shared_pref_helper.dart';
import 'package:anime/model/anime_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<GetFavoriteEvent>(getdata);
  }

  FutureOr<void> getdata(
      GetFavoriteEvent event, Emitter<FavoriteState> emit) async {
    emit(Favoriteloading());

    List<Datum> mylist = await SharedPreferencesHelper.getItems();

    emit(FavoriteLoaded(mylist: mylist));
  }
}
