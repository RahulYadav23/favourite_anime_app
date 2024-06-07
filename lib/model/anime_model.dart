import 'package:equatable/equatable.dart';

class AnimeModel {
  AnimeModel({
    required this.pagination,
    required this.data,
  });

  final Pagination? pagination;
  final List<Datum> data;

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Datum extends Equatable {
  Datum({
    required this.images,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.aired,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.background,
    required this.season,
    required this.year,
    required this.genres,
  });

  final Map<String, AnimePhoto> images;
  final String? title;
  final String? titleEnglish;
  final String? titleJapanese;
  final String? type;
  final String? source;
  final num? episodes;
  final String? status;
  final Aired? aired;
  final String? duration;
  final String? rating;
  final num? score;
  final num? scoredBy;
  final num? rank;
  final num? popularity;
  final num? members;
  final num? favorites;
  final String? synopsis;
  final String? background;
  final String? season;
  final num? year;
  final List<Genre> genres;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      images: Map.from(json["images"]).map(
          (k, v) => MapEntry<String, AnimePhoto>(k, AnimePhoto.fromJson(v))),
      title: json["title"],
      titleEnglish: json["title_english"],
      titleJapanese: json["title_japanese"],
      type: json["type"],
      source: json["source"],
      episodes: json["episodes"],
      status: json["status"],
      aired: json["aired"] == null ? null : Aired.fromJson(json["aired"]),
      duration: json["duration"],
      rating: json["rating"],
      score: json["score"],
      scoredBy: json["scored_by"],
      rank: json["rank"],
      popularity: json["popularity"],
      members: json["members"],
      favorites: json["favorites"],
      synopsis: json["synopsis"],
      background: json["background"],
      season: json["season"],
      year: json["year"],
      genres: json["genres"] == null
          ? []
          : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "images": Map.from(images)
            .map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
        "title": title,
        "title_english": titleEnglish,
        "title_japanese": titleJapanese,
        "type": type,
        "source": source,
        "episodes": episodes,
        "status": status,
        "aired": aired?.toJson(),
        "duration": duration,
        "rating": rating,
        "score": score,
        "scored_by": scoredBy,
        "rank": rank,
        "popularity": popularity,
        "members": members,
        "favorites": favorites,
        "synopsis": synopsis,
        "background": background,
        "season": season,
        "year": year,
        "genres": genres.map((x) => x?.toJson()).toList(),
      };

  @override
  List<Object?> get props => [title];
}

class Aired {
  Aired({
    required this.string,
  });

  final String? string;

  factory Aired.fromJson(Map<String, dynamic> json) {
    return Aired(
      string: json["string"],
    );
  }

  Map<String, dynamic> toJson() => {
        "string": string,
      };
}

class Genre {
  Genre({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  final int? malId;
  final String? type;
  final String? name;
  final String? url;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      malId: json["mal_id"],
      type: json["type"],
      name: json["name"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "mal_id": malId,
        "type": type,
        "name": name,
        "url": url,
      };
}

class AnimePhoto {
  AnimePhoto({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  final String? imageUrl;
  final String? smallImageUrl;
  final String? largeImageUrl;

  factory AnimePhoto.fromJson(Map<String, dynamic> json) {
    return AnimePhoto(
      imageUrl: json["image_url"],
      smallImageUrl: json["small_image_url"],
      largeImageUrl: json["large_image_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "small_image_url": smallImageUrl,
        "large_image_url": largeImageUrl,
      };
}

class Pagination {
  Pagination({
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.currentPage,
    required this.items,
  });

  final num? lastVisiblePage;
  final bool? hasNextPage;
  final num? currentPage;
  final Items? items;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      lastVisiblePage: json["last_visible_page"],
      hasNextPage: json["has_next_page"],
      currentPage: json["current_page"],
      items: json["items"] == null ? null : Items.fromJson(json["items"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "last_visible_page": lastVisiblePage,
        "has_next_page": hasNextPage,
        "current_page": currentPage,
        "items": items?.toJson(),
      };
}

class Items {
  Items({
    required this.count,
    required this.total,
    required this.perPage,
  });

  final num? count;
  final num? total;
  final num? perPage;

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      count: json["count"],
      total: json["total"],
      perPage: json["per_page"],
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "per_page": perPage,
      };
}
