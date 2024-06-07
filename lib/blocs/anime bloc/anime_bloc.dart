import 'dart:async';

import 'package:anime/data/shared_pref_helper.dart';
import 'package:anime/repository/anime_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anime/model/anime_model.dart';
part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  AnimeRepository animeRepository = AnimeRepository();
  int pageNo = 1;
  List<Datum> mylist = [];
  AnimeBloc() : super(AnimeInitialState()) {
    on<FirstFetchEvent>(initialfetch);
    on<LoadmoreEvent>(fetchmore, transformer: droppable());
    on<AddtoFavEvent>(addtofav);
    on<RemoveFavEvent>(removeanime);
  }

  FutureOr<void> initialfetch(
      FirstFetchEvent event, Emitter<AnimeState> emit) async {
    emit(AnimeLoadingState());
    final animedata = await animeRepository.fetchAnime(page: pageNo);
    mylist.addAll(animedata.data);

    emit(AnimeLoadedState(mylist: mylist, isloading: false));
  }

  FutureOr<void> fetchmore(
      LoadmoreEvent event, Emitter<AnimeState> emit) async {
    emit(AnimeLoadedState(mylist: mylist, isloading: true));
    pageNo++;
    final animedata = await animeRepository.fetchAnime(page: pageNo);
    mylist.addAll(animedata.data);
    emit(AnimeLoadedState(mylist: mylist, isloading: false));
  }

  FutureOr<void> addtofav(AddtoFavEvent event, Emitter<AnimeState> emit) async {
    List<Datum> list = await SharedPreferencesHelper.getItems();
    if (list.isEmpty) {
      await SharedPreferencesHelper.saveSingleItem(event.data);
      emit(ShowInfoState(message: "Anime  is added"));
    } else {
      if (list.contains(event.data)) {
        emit(ShowInfoState(message: "Anime is Already added"));
      } else {
        await SharedPreferencesHelper.saveSingleItem(event.data);
        emit(ShowInfoState(message: "Anime is added"));
      }
    }
  }

  FutureOr<void> removeanime(
      RemoveFavEvent event, Emitter<AnimeState> emit) async {
    List<Datum> list = await SharedPreferencesHelper.getItems();

    list.remove(event.data);

    await SharedPreferencesHelper.saveItems(list);
    emit(ShowInfoState(message: "Anime is removed"));
  }
}
