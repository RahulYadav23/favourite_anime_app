import 'package:anime/model/anime_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static const String keyItemsList = 'items';

  static Future<void> saveItems(List<Datum> items) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonItems =
        items.map((item) => jsonEncode(item.toJson())).toList();
    prefs.setStringList(keyItemsList, jsonItems);
  }

  static Future<List<Datum>> getItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonItems = prefs.getStringList(keyItemsList);
    if (jsonItems == null) {
      return [];
    }
    return jsonItems
        .map((jsonItem) => Datum.fromJson(jsonDecode(jsonItem)))
        .toList();
  }

  static Future<void> saveSingleItem(Datum item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Datum> items = await getItems();
    items.add(item);
    List<String> jsonItems = items.map((i) => jsonEncode(i.toJson())).toList();
    prefs.setStringList(keyItemsList, jsonItems);
  }

  static Future<void> clearItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyItemsList);
  }
}
