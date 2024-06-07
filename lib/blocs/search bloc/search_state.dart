part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedstate extends SearchState {
  final List<Datum> mylist;

  SearchLoadedstate({required this.mylist});
}
