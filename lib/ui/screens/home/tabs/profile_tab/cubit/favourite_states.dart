

import 'package:movies_app/data/model/list_movies_model.dart';

abstract class FavouriteStates {}

class FavouriteInitial extends FavouriteStates {}

class FavouriteLoading extends FavouriteStates {}

class FavouriteLoaded extends FavouriteStates {
  final List<Movies> favourites;

  FavouriteLoaded(this.favourites);
}

class FavouriteError extends FavouriteStates {
  final String message;

  FavouriteError(this.message);
}
