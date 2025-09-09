import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/Api/movie_api_service.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService apiService;
  MovieBloc({required this.apiService}) : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    // on<GetMovieDetails>(_onGetMovieDetailsWithSuggestions);
    // on<GetSuggestedMovies>(_onGetSuggestedMovies);
  }

  // get list of movies
  FutureOr<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());

    try {
      final MovieDataModel movies = await ApiService.getMovies();
      emit(MovieSuccess(movies));
    } catch (e) {
      emit(MovieError("fetch all movies${e.toString()}"));
    }
  }

  //get movie details
  // FutureOr<void> _onGetMovieDetailsWithSuggestions(
  //   GetMovieDetails event,
  //   Emitter<MovieState> emit,
  // ) async {
  //   emit(MovieLoading());

  //   try {
  //     final MovieDataModel suggested = await ApiService.getMovieSuggestions(
  //       movieId: event.movieId,
  //     );
  //     final MovieDataModel movieResponse = await ApiService.getMovieDetails(
  //       movieId: event.movieId,
  //     );
  //     if (movieResponse.data?.movie != null && movieResponse.status == 'ok') {
  //       // if (suggested.data?.movies != null && suggested.status == 'ok') {
  //         emit(
  //           MovieDetailsSuccess(
  //             movie: movieResponse.data!.movie!,
  //             suggestedMovies: suggested.data?.movies ?? [],
  //           ),
  //         );
  //       // }
  //     } else {
  //       emit(
  //         MovieError(
  //           movieResponse.statusMessage ??
  //               '${movieResponse.status}: Failed to load movie details',
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     emit(MovieError('movie bloc details screen error ${e.toString()}'));
  //   }
  // }
  // //get suggested movies
  // FutureOr<void> _onGetSuggestedMovies(
  //   GetSuggestedMovies event,
  //   Emitter<MovieState> emit,
  // ) async {
  //   emit(MovieLoading());

  //   try {
  //     final ListMoviesModel response  = await ApiService.getMovieSuggestions(movieId: event.movieId);
  //     if(response.data?.movies != null && response.status == 'ok'){
  //       emit(MovieSuggestionsSuccess(movies: response.data?.movies ?? []));
  //     }else{
  //       emit(MovieError(response.statusMessage ?? '${response.status}: Failed to load movie details'));
  //     }
  //   } catch (e) {
  //     emit(MovieError(e.toString()));
  //   }
  // }
}
