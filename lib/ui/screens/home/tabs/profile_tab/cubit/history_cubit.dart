import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/Api/history_api_service.dart';
import 'package:movies_app/data/datasources/history/history_datasource_impl.dart';
import 'package:movies_app/data/repositories/history/history_repository_impl.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_states.dart';

class HistoryCubit extends Cubit<HistoryStates> {
  late final HistoryRepositoryImpl repository;

  HistoryCubit() : super(HistoryInitial()) {
    final apiService = HistoryApiService();
    final dataSource = HistoryDataSourceImpl(apiService);
    repository = HistoryRepositoryImpl(dataSource);
  }

  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      final movies = await repository.getHistoryMovies();
      emit(HistoryLoaded(movies));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
