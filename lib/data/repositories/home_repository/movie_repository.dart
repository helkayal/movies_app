
import 'package:movies_app/data/model/movie_data_model.dart';

class MovieRepository {
  static List<String> getGenres({required List<Movie> movies}) {
    //عملت set فاضيه عشان اقدر اضيف فيها كل list هتيجى من ال Api وتمنع تكرار  اى حاجه
    Set<String> genersSet = {};
    // هجيب ال geners عن طريق اللوب واضيفها جوا ال سيت

    for (int i = 0; i < movies.length; i++) {
      final List<String>? geners = movies[i].genres;
      genersSet.addAll(geners!.map((e) => e.toString()));
    }
    // السيت بقت عندى جاهزة مافيهاش تكرار هحولها ل ليست واساويها بالليست الفاضيه الى عندى
    return genersSet.toList();
  }

  static List<Movie> getMoviesByGenres({
    required String genre,
    required List<Movie> movies,
  }) {
    List<Movie> moviesByGenres = [];
    for (var movie in movies) {
      final List<String>? movieGeners = movie.genres;
      if (movieGeners!.contains(genre)) {
        moviesByGenres.add(movie);
      }
    }
    return moviesByGenres;
  }

  static List<Movie> addSearchedValueToSearchedList({
    required String searchedMovie,
    required List<Movie> movies,
  }) {
    if (searchedMovie.isEmpty) {
      return [];
    } else {
      return movies
          .where(
            (movie) => movie.title!.toLowerCase().startsWith(searchedMovie),
          )
          .toList();
    }
  }
}
