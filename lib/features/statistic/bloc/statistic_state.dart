import 'package:equatable/equatable.dart';
import 'package:re_task/models/statistic_model.dart';

abstract class StatisticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final TaskStatusStatistics statistics;

  StatisticsLoaded({required this.statistics});

  @override
  List<Object?> get props => [statistics];
}

class StatisticsError extends StatisticsState {
  final String message;

  StatisticsError({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
