part of 'movie_bloc.dart';

@immutable
abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

//list of movies states
class MovieSuccess extends MovieState {
  final MovieDataModel movies;

  const MovieSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

//movie details states
class MovieDetailsSuccess extends MovieState {
  final Movie movie;
  final List<Movie> suggestedMovies;
  const MovieDetailsSuccess({required this.movie,required this.suggestedMovies});
  @override
  List<Object> get props => [movie,suggestedMovies];
}

//get suggested movies


//Shared
final class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}
