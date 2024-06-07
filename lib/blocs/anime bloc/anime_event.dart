part of 'anime_bloc.dart';

abstract class AnimeEvent {}

class FirstFetchEvent extends AnimeEvent {}

class LoadmoreEvent extends AnimeEvent {}

class AddtoFavEvent extends AnimeEvent {
  Datum data;
  AddtoFavEvent({required this.data});
}

class RemoveFavEvent extends AnimeEvent {
  Datum data;
  RemoveFavEvent({required this.data});
}
