part of 'anime_bloc.dart';

abstract class AnimeState {}

class AnimeListenState extends AnimeState {}

class AnimeBuildState extends AnimeState {}

class AnimeInitialState extends AnimeState {}

class AnimeLoadingState extends AnimeBuildState {}

class AnimeLoadedState extends AnimeBuildState {
  final bool isloading;
  final List<Datum> mylist;

  AnimeLoadedState({required this.mylist, required this.isloading});
}

class AnimeErrorState extends AnimeBuildState {}

class ShowInfoState extends AnimeListenState {
  String message;
  ShowInfoState({required this.message});
}
