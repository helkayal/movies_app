part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

//get all movies
class FetchMoviesEvent extends MovieEvent {
  const FetchMoviesEvent();
}

//get movie details
// class GetMovieDetails extends MovieEvent {
//   final int movieId;
//   const GetMovieDetails({required this.movieId});
//   @override
//   List<Object> get props => [movieId];
// }
// //get list of suggested movies
// class GetSuggestedMovies extends MovieEvent{
//   final int movieId;
//   const GetSuggestedMovies({required this.movieId});
//   @override
//   List<Object> get props => [movieId];
// }
