import 'package:movies_app/data/datasources/favourite/favourite_data_source.dart';
import 'package:movies_app/data/repositories/favourite/favourite_repository.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteDataSource dataSource;

  FavouriteRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> fetchFavourites() async {
    return await dataSource.fetchFavourites();
  }
}
