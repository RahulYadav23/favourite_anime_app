part of 'favorite_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class Favoriteloading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  List<Datum> mylist;
  FavoriteLoaded({required this.mylist});
}
