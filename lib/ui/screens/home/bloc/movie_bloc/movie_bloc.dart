
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/Api/movie_api_service.dart';
import 'package:movies_app/data/model/list_movies_model.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService apiService;
  MovieBloc({required this.apiService}) : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
    on<GetMovieDetails>(_onGetMovieDetails);
  }

  // get list of movies
  FutureOr<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    
    try {
      final ListMoviesModel movies = await ApiService.getMovies();
      emit(MovieSuccess(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
  //get movie details
  FutureOr<void> _onGetMovieDetails(
    GetMovieDetails event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());

    try {
      final MovieDetailsModel response  = await ApiService.getMovieDetails(movieId: event.movieId);
      if(response.data?.movie != null && response.status == 'ok'){
        emit(MovieDetailsSuccess(movie: response.data!.movie!));
      }else{
        emit(MovieError(response.statusMessage ?? '${response.status}: Failed to load movie details'));
      }
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
  
}
