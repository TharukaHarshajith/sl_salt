part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataSaving extends DataState {}

class SaveDataSuccessful extends DataState {}

class SaveDataError extends DataState {
  final String error;
  const SaveDataError(this.error);

  @override
  List<Object> get props => [error];
}
