import 'package:bloc/bloc.dart';
import 'package:re_task/features/statistic/bloc/statistic_event.dart';
import 'package:re_task/features/statistic/bloc/statistic_state.dart';
import 'package:re_task/features/statistic/data/statistic_repository.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsRepository _repository;

  StatisticsBloc({required StatisticsRepository repository})
      : _repository = repository,
        super(StatisticsInitial()) {
    on<FetchStatisticsEvent>(_onFetchStatistics);
  }

  Future<void> _onFetchStatistics(
    FetchStatisticsEvent event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(StatisticsLoading());
    try {
      final stats = await _repository.fetchStatistics();
      emit(StatisticsLoaded(statistics: stats));
    } catch (e) {
      print("Error fetching statistics: $e");
      emit(StatisticsError(message: 'Failed to load statistics'));
    }
  }
}
