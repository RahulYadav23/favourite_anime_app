part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchValue extends SearchEvent {
  String value;
  SearchValue({required this.value});
}
