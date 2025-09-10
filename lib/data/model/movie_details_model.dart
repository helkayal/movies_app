class MovieDataModel {
  final String? status;
  final String? statusMessage;
  final Data? data;

  MovieDataModel({this.status, this.statusMessage, this.data});

  factory MovieDataModel.fromJson(Map<String, dynamic> json) {
    return MovieDataModel(
      status: json['status'],
      statusMessage: json['status_message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}

class Data {
  final Movie? movie;
  final List<Movie>? movies;
  final int? movieCount;
  final int? limit;
  final int? pageNumber;

  Data({this.movie, this.movies, this.movieCount, this.limit, this.pageNumber});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      movie: json['movie'] != null ? Movie.fromJson(json['movie']) : null,
      movies: json['movies'] != null
          ? (json['movies'] as List).map((i) => Movie.fromJson(i)).toList()
          : null,
      movieCount: json['movie_count'],
      limit: json['limit'],
      pageNumber: json['page_number'],
    );
  }
}

class Movie {
  final int? id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? ytTrailerCode;
  final String? language;
  final String? mediumCoverImage;

  // Extra parameters for Movie details
  final int? likeCount;
  final String? descriptionIntro;
  final String? descriptionFull;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String? largeCoverImage;
  final String? mediumScreenshotImage1;
  final String? mediumScreenshotImage2;
  final String? mediumScreenshotImage3;
  final String? largeScreenshotImage1;
  final String? largeScreenshotImage2;
  final String? largeScreenshotImage3;
  final List<Cast>? cast;
  final List<Torrents>? torrents;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.ytTrailerCode,
    this.language,
    this.mediumCoverImage,
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.largeCoverImage,
    this.mediumScreenshotImage1,
    this.mediumScreenshotImage2,
    this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    this.cast,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  // Factory constructor for both list and details
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      url: json['url'],
      imdbCode: json['imdb_code'],
      title: json['title'],
      titleEnglish: json['title_english'],
      titleLong: json['title_long'],
      slug: json['slug'],
      year: json['year'],
      rating: (json['rating'] as num?)?.toDouble(),
      runtime: json['runtime'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      ytTrailerCode: json['yt_trailer_code'],
      language: json['language'],
      mediumCoverImage: json['medium_cover_image'],
      likeCount: json['like_count'],
      descriptionIntro: json['description_intro'],
      descriptionFull: json['description_full'],
      mpaRating: json['mpa_rating'],
      backgroundImage: json['background_image'],
      backgroundImageOriginal: json['background_image_original'],
      smallCoverImage: json['small_cover_image'],
      largeCoverImage: json['large_cover_image'],
      mediumScreenshotImage1: json['medium_screenshot_image1'],
      mediumScreenshotImage2: json['medium_screenshot_image2'],
      mediumScreenshotImage3: json['medium_screenshot_image3'],
      largeScreenshotImage1: json['large_screenshot_image1'],
      largeScreenshotImage2: json['large_screenshot_image2'],
      largeScreenshotImage3: json['large_screenshot_image3'],
      cast: json['cast'] != null
          ? (json['cast'] as List).map((v) => Cast.fromJson(v)).toList()
          : null,
      torrents: json['torrents'] != null
          ? (json['torrents'] as List).map((v) => Torrents.fromJson(v)).toList()
          : null,
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['medium_cover_image'] = mediumCoverImage;
    map['like_count'] = likeCount;
    map['description_intro'] = descriptionIntro;
    map['description_full'] = descriptionFull;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['medium_screenshot_image1'] = mediumScreenshotImage1;
    map['medium_screenshot_image2'] = mediumScreenshotImage2;
    map['medium_screenshot_image3'] = mediumScreenshotImage3;
    map['large_screenshot_image1'] = largeScreenshotImage1;
    map['large_screenshot_image2'] = largeScreenshotImage2;
    map['large_screenshot_image3'] = largeScreenshotImage3;
    if (cast != null) {
      map['cast'] = cast?.map((v) => v.toJson()).toList();
    }
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

  /// Convert only essential fields for history
  Map<String, dynamic> toHistoryMap() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'year': year,
      'mediumCoverImage':
          largeCoverImage ?? mediumCoverImage ?? smallCoverImage,
    };
  }

  /// Create a Movie object from history map
  factory Movie.fromHistoryMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      rating: (map['rating'] as num?)?.toDouble(),
      year: map['year'],
      mediumCoverImage: map['mediumCoverImage'],
    );
  }
}

class Torrents {
  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Torrents.fromJson(dynamic json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['hash'] = hash;
    map['quality'] = quality;
    map['type'] = type;
    map['is_repack'] = isRepack;
    map['video_codec'] = videoCodec;
    map['bit_depth'] = bitDepth;
    map['audio_channels'] = audioChannels;
    map['seeds'] = seeds;
    map['peers'] = peers;
    map['size'] = size;
    map['size_bytes'] = sizeBytes;
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }
}

class Cast {
  Cast({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }
}
