import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/data/model/movie_dm.dart';

class MovieRepository {
  static List<String> getGenres({required List<Movies> movies}) {
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
  static List<Movies> getMoviesByGenres({required String genre ,required List<Movies> movies}){
    List<Movies> moviesByGenres = [];
    for (var movie in movies) {
      final List<String>? movieGeners = movie.genres;
      if(movieGeners!.contains(genre)){
        moviesByGenres.add(movie);
      }
    }return moviesByGenres;
  }
  static List<Movies> searchForMovie({required String movieName,required List<Movies> movies}){
//بتدخل ف كل فيلم تشوف اسمههو نفس الباراميتار ولا لا ولو اه بتحطه فى ليست وترحعه
    List<Movies> recievedMovies =[];
    for(var movie in movies){
      if(movie.title!.toLowerCase().contains(movieName.toLowerCase().trim())){
        recievedMovies.add(movie);
        }
      }
    return recievedMovies ;
  }
}
