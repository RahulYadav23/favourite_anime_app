import 'package:anime/model/anime_model.dart';
import 'package:dio/dio.dart';

class AnimeRepository {
  Dio dio = Dio();

  Future<dynamic> fetchAnime({required int page}) async {
    try {
      final response =
          await dio.get('https://api.jikan.moe/v4/anime', queryParameters: {
        'page': page,
        'limit': 20,
      });

      if (response.statusCode == 200) {
        return AnimeModel.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print(error.toString());
      print(stacktrace.toString());
      return null;
    }
  }

  Future<dynamic> searchAnime(String query) async {
    try {
      var dio = Dio();
      final response =
          await dio.get('https://api.jikan.moe/v4/anime', queryParameters: {
        'q': query,
      });

      if (response.statusCode == 200) {
        return AnimeModel.fromJson(response.data);
      }
    } catch (error) {
      return null;
    }
  }
}
