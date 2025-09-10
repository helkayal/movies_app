import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/Api/movie_api_service.dart';
import 'package:movies_app/data/datasources/history/history_service.dart';
import 'package:movies_app/data/model/movie_details_model.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitial()) {
    on<GetMovieDetails>(_onGetMovieDetails);
  }

  Future<void> _onGetMovieDetails(
    GetMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());
    try {
      final Movie movie = await ApiService.getMovieDetails(
        movieId: event.movieId,
      );
      final List<Movie> suggestedMovies = await ApiService.getMovieSuggestions(
        movieId: event.movieId,
      );

      emit(MovieDetailsSuccess(movie: movie, suggestedMovies: suggestedMovies));

      //Save into history
      await HistoryService.addToHistory(movie);
    } catch (e) {
      emit(MovieDetailsError(message: e.toString()));
    }
  }
}
