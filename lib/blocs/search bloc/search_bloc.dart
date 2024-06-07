import 'dart:async';

import 'package:anime/model/anime_model.dart';
import 'package:anime/repository/anime_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  AnimeRepository animeRepository = AnimeRepository();
  SearchBloc() : super(SearchInitial()) {
    on<SearchValue>(searchmethod);
  }

  FutureOr<void> searchmethod(
      SearchValue event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    if (event.value.isNotEmpty) {
      final animedata = await animeRepository.searchAnime(event.value);

      emit(SearchLoadedstate(
        mylist: animedata.data,
      ));
    } else {
      emit(SearchLoadedstate(
        mylist: [],
      ));
    }
  }
}
