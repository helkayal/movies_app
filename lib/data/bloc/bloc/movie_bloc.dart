import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/Api/api_service.dart';
import 'package:movies_app/data/model/movie_dm.dart';
import 'package:movies_app/ui/screens/home/bloc/movie_bloc/movie_bloc.dart';

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
