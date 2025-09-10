import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/datasources/history/history_datasource_impl.dart';
import 'package:movies_app/data/repositories/history/history_repository_impl.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_states.dart';
import 'package:movies_app/data/model/movie_details_model.dart';

class HistoryCubit extends Cubit<HistoryStates> {
  late final HistoryRepositoryImpl repository;

  HistoryCubit() : super(HistoryInitial()) {
    final dataSource = HistoryDataSourceImpl();
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

  Future<void> addMovie(Movie movie) async {
    try {
      await repository.addMovie(movie);
      final movies = await repository.getHistoryMovies();
      emit(HistoryLoaded(movies));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> clearHistory() async {
    try {
      await repository.clearHistory();
      emit(HistoryLoaded([]));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
