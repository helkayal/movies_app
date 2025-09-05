import 'package:movies_app/data/datasources/Api/favourite_api_service.dart';
import 'package:movies_app/data/datasources/favourite/favourite_data_source.dart';

class FavouriteDataSourceImpl extends FavouriteDataSource {
  final FavouriteApiService apiService;

  FavouriteDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> fetchFavourites() async {
    return await apiService.fetchFavourites();
  }
}
