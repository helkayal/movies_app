import 'package:movies_app/data/model/movie_details_model.dart';

abstract class HistoryStates {}

class HistoryInitial extends HistoryStates {}

class HistoryLoading extends HistoryStates {}

class HistoryLoaded extends HistoryStates {
  final List<Movie> movies;
  HistoryLoaded(this.movies);
}

class HistoryError extends HistoryStates {
  final String message;
  HistoryError(this.message);
}
