import 'package:movies_app/data/model/movie_data_model.dart';

abstract class FavouriteStates {}

class FavouriteInitial extends FavouriteStates {}

class FavouriteLoading extends FavouriteStates {}

class FavouriteLoaded extends FavouriteStates {
  final List<Movie> favourites;

  FavouriteLoaded(this.favourites);
}

class FavouriteAdded extends FavouriteStates {}

class FavouriteRemoved extends FavouriteStates {}

class isFavouriteLoaded extends FavouriteStates {}

class FavouriteError extends FavouriteStates {
  final String message;

  FavouriteError(this.message);
}
