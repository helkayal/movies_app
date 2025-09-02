import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/Api/api_service.dart';
import 'package:movies_app/model/movie_dm.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<FetchMoviesEvent>(_onFetchMovies);
  }

  FutureOr<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());
    
    try {
      final MovieDataModel movies = await ApiService.getMovies();
      emit(MovieSuccess(movies));
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
