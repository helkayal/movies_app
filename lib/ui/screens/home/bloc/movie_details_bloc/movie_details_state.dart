import 'package:equatable/equatable.dart';
import 'package:movies_app/data/model/movie_data_model.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object?> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final Movie movie;
  final List<Movie> suggestedMovies;

  const MovieDetailsSuccess({
    required this.movie,
    required this.suggestedMovies,
  });

  @override
  List<Object?> get props => [movie, suggestedMovies];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  const MovieDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
