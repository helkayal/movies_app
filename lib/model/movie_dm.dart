class MovieDataModel {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final int likeCount;
  final String descriptionIntro;
  final String descriptionFull;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<MovieTorrent> torrents;
  final String dateUploaded;
  final int dateUploadedUnix;

  MovieDataModel({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) {
    return MovieDataModel(
      id: json["id"] ?? 0,
      url: json["url"] ?? "",
      imdbCode: json["imdb_code"] ?? "",
      title: json["title"] ?? "",
      titleEnglish: json["title_english"] ?? "",
      titleLong: json["title_long"] ?? "",
      slug: json["slug"] ?? "",
      year: json["year"] ?? 0,
      rating: (json["rating"] ?? 0).toDouble(),
      runtime: json["runtime"] ?? 0,
      genres: List<String>.from(json["genres"] ?? []),
      likeCount: json["like_count"] ?? 0,
      descriptionIntro: json["description_intro"] ?? "",
      descriptionFull: json["description_full"] ?? "",
      ytTrailerCode: json["yt_trailer_code"] ?? "",
      language: json["language"] ?? "",
      mpaRating: json["mpa_rating"] ?? "",
      backgroundImage: json["background_image"] ?? "",
      backgroundImageOriginal: json["background_image_original"] ?? "",
      smallCoverImage: json["small_cover_image"] ?? "",
      mediumCoverImage: json["medium_cover_image"] ?? "",
      largeCoverImage: json["large_cover_image"] ?? "",
      torrents:
          (json["torrents"] as List<dynamic>?)
              ?.map((e) => MovieTorrent.fromJson(e))
              .toList() ??
          [],
      dateUploaded: json["date_uploaded"] ?? "",
      dateUploadedUnix: json["date_uploaded_unix"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "imdb_code": imdbCode,
      "title": title,
      "title_english": titleEnglish,
      "title_long": titleLong,
      "slug": slug,
      "year": year,
      "rating": rating,
      "runtime": runtime,
      "genres": genres,
      "like_count": likeCount,
      "description_intro": descriptionIntro,
      "description_full": descriptionFull,
      "yt_trailer_code": ytTrailerCode,
      "language": language,
      "mpa_rating": mpaRating,
      "background_image": backgroundImage,
      "background_image_original": backgroundImageOriginal,
      "small_cover_image": smallCoverImage,
      "medium_cover_image": mediumCoverImage,
      "large_cover_image": largeCoverImage,
      "torrents": torrents.map((e) => e.toJson()).toList(),
      "date_uploaded": dateUploaded,
      "date_uploaded_unix": dateUploadedUnix,
    };
  }
}

class MovieTorrent {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final String isRepack;
  final String videoCodec;
  final String bitDepth;
  final String audioChannels;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;

  MovieTorrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.isRepack,
    required this.videoCodec,
    required this.bitDepth,
    required this.audioChannels,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieTorrent.fromJson(Map<String, dynamic> json) {
    return MovieTorrent(
      url: json["url"] ?? "",
      hash: json["hash"] ?? "",
      quality: json["quality"] ?? "",
      type: json["type"] ?? "",
      isRepack: json["is_repack"] ?? "",
      videoCodec: json["video_codec"] ?? "",
      bitDepth: json["bit_depth"] ?? "",
      audioChannels: json["audio_channels"] ?? "",
      seeds: json["seeds"] ?? 0,
      peers: json["peers"] ?? 0,
      size: json["size"] ?? "",
      sizeBytes: json["size_bytes"] ?? 0,
      dateUploaded: json["date_uploaded"] ?? "",
      dateUploadedUnix: json["date_uploaded_unix"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "hash": hash,
      "quality": quality,
      "type": type,
      "is_repack": isRepack,
      "video_codec": videoCodec,
      "bit_depth": bitDepth,
      "audio_channels": audioChannels,
      "seeds": seeds,
      "peers": peers,
      "size": size,
      "size_bytes": sizeBytes,
      "date_uploaded": dateUploaded,
      "date_uploaded_unix": dateUploadedUnix,
    };
  }
}
