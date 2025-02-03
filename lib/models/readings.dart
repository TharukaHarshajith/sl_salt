import 'package:equatable/equatable.dart';

class ReadingModel extends Equatable {
  String? id;
  String userId;
  String? saltern;
  String dateOfReading;
  double? morningUpPool1;
  double? morningDownPool1;
  double? eveningUpPool1;
  double? eveningDownPool1;
  double? morningUpPool2;
  double? morningDownPool2;
  double? eveningUpPool2;
  double? eveningDownPool2;
  double? morningUpPool3;
  double? morningDownPool3;
  double? eveningUpPool3;
  double? eveningDownPool3;
  double? RF;

  ReadingModel({
    this.id,
    required this.userId,
    required this.saltern,
    required this.dateOfReading,
    this.morningUpPool1,
    this.morningDownPool1,
    this.eveningUpPool1,
    this.eveningDownPool1,
    this.morningUpPool2,
    this.morningDownPool2,
    this.eveningUpPool2,
    this.eveningDownPool2,
    this.morningUpPool3,
    this.morningDownPool3,
    this.eveningUpPool3,
    this.eveningDownPool3,
    this.RF,
  });

  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      saltern: json['saltern'] as String?,
      dateOfReading: json['dateOfReading'] as String,
      morningUpPool1: json['morningUpPool1'] as double?,
      morningDownPool1: json['morningDownPool1'] as double?,
      eveningUpPool1: json['eveningUpPool1'] as double?,
      eveningDownPool1: json['eveningDownPool1'] as double?,
      morningUpPool2: json['morningUpPool2'] as double?,
      morningDownPool2: json['morningDownPool2'] as double?,
      eveningUpPool2: json['eveningUpPool2'] as double?,
      eveningDownPool2: json['eveningDownPool2'] as double?,
      morningUpPool3: json['morningUpPool3'] as double?,
      morningDownPool3: json['morningDownPool3'] as double?,
      eveningUpPool3: json['eveningUpPool3'] as double?,
      eveningDownPool3: json['eveningDownPool3'] as double?,
      RF: json['RF'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'saltern': saltern,
      'dateOfReading': dateOfReading,
      'morningUpPool1': morningUpPool1,
      'morningDownPool1': morningDownPool1,
      'eveningUpPool1': eveningUpPool1,
      'eveningDownPool1': eveningDownPool1,
      'morningUpPool2': morningUpPool2,
      'morningDownPool2': morningDownPool2,
      'eveningUpPool2': eveningUpPool2,
      'eveningDownPool2': eveningDownPool2,
      'morningUpPool3': morningUpPool3,
      'morningDownPool3': morningDownPool3,
      'eveningUpPool3': eveningUpPool3,
      'eveningDownPool3': eveningDownPool3,
      'RF': RF,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        saltern,
        dateOfReading,
        morningUpPool1,
        morningDownPool1,
        eveningUpPool1,
        eveningDownPool1,
        morningUpPool2,
        morningDownPool2,
        eveningUpPool2,
        eveningDownPool2,
        morningUpPool3,
        morningDownPool3,
        eveningUpPool3,
        eveningDownPool3,
        RF,
      ];
}
