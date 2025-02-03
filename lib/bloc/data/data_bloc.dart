import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sl_salt/models/readings.dart';
import 'package:sl_salt/models/users.dart';
import 'package:sl_salt/repositories/data/data_repository.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataRepository dataRepository;

  DataBloc({required this.dataRepository}) : super(DataInitial()) {
    on<SaveDataEvent>(_onSaveData);
  }

  Future<void> _onSaveData(SaveDataEvent event, Emitter<DataState> emit) async {
    emit(DataSaving());
    try {
      await dataRepository.saveData(
        morningReading1: event.morningReading1,
        morningReading2: event.morningReading2,
        eveningReading1: event.eveningReading1,
        eveningReading2: event.eveningReading2,
        dailyRainfall: event.dailyRainfall,
        pool: event.pool,
        dateOfReading: event.dateOfReading,
        user: event.user,
      );
      emit(SaveDataSuccessful());
    } catch (e) {
      emit(SaveDataError(e.toString()));
    }
  }
}
