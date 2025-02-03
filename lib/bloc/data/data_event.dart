part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class SaveDataEvent extends DataEvent {
  final double morningReading1;
  final double morningReading2;
  final double eveningReading1;
  final double eveningReading2;
  final double dailyRainfall;
  final String pool;
  final DateTime dateOfReading;
  final String user;

  const SaveDataEvent({
    required this.morningReading1,
    required this.morningReading2,
    required this.eveningReading1,
    required this.eveningReading2,
    required this.dailyRainfall,
    required this.pool,
    required this.dateOfReading,
    required this.user,
  });

  @override
  List<Object> get props => [morningReading1, morningReading2, eveningReading1, eveningReading2, dailyRainfall, pool, dateOfReading,user];
}
