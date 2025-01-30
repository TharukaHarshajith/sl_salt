import 'package:equatable/equatable.dart';

class ReadingModel extends Equatable {
  final String? id;
  final String userId;
  final String saltern;
  final DateTime dateOfReading;
  final double DMU_pool1;
  final double DMD_pool1;
  final double DEU_pool1;
  final double DED_pool1;
  final double DMU_pool2;
  final double DMD_pool2;
  final double DEU_pool2;
  final double DED_pool2;
  final double DMU_pool3;
  final double DMD_pool3;
  final double DEU_pool3;
  final double DED_pool3;
  final double RF;

  const ReadingModel({
    this.id,
    required this.userId,
    required this.saltern,
    required this.dateOfReading,
    required this.DMU_pool1,
    required this.DMD_pool1,
    required this.DEU_pool1,
    required this.DED_pool1,
    required this.DMU_pool2,
    required this.DMD_pool2,
    required this.DEU_pool2,
    required this.DED_pool2,
    required this.DMU_pool3,
    required this.DMD_pool3,
    required this.DEU_pool3,
    required this.DED_pool3,
    required this.RF,
  });

  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      saltern: json['saltern'] as String,
      dateOfReading: DateTime.parse(json['dateOfReading'] as String),
      DMU_pool1: (json['DMU_pool1'] as num).toDouble(),
      DMD_pool1: (json['DMD_pool1'] as num).toDouble(),
      DEU_pool1: (json['DEU_pool1'] as num).toDouble(),
      DED_pool1: (json['DED_pool1'] as num).toDouble(),
      DMU_pool2: (json['DMU_pool2'] as num).toDouble(),
      DMD_pool2: (json['DMD_pool2'] as num).toDouble(),
      DEU_pool2: (json['DEU_pool2'] as num).toDouble(),
      DED_pool2: (json['DED_pool2'] as num).toDouble(),
      DMU_pool3: (json['DMU_pool3'] as num).toDouble(),
      DMD_pool3: (json['DMD_pool3'] as num).toDouble(),
      DEU_pool3: (json['DEU_pool3'] as num).toDouble(),
      DED_pool3: (json['DED_pool3'] as num).toDouble(),
      RF: (json['RF'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'saltern': saltern,
      'dateOfReading': dateOfReading.toIso8601String(),
      'DMU_pool1': DMU_pool1,
      'DMD_pool1': DMD_pool1,
      'DEU_pool1': DEU_pool1,
      'DED_pool1': DED_pool1,
      'DMU_pool2': DMU_pool2,
      'DMD_pool2': DMD_pool2,
      'DEU_pool2': DEU_pool2,
      'DED_pool2': DED_pool2,
      'DMU_pool3': DMU_pool3,
      'DMD_pool3': DMD_pool3,
      'DEU_pool3': DEU_pool3,
      'DED_pool3': DED_pool3,
      'RF': RF,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        saltern,
        dateOfReading,
        DMU_pool1,
        DMD_pool1,
        DEU_pool1,
        DED_pool1,
        DMU_pool2,
        DMD_pool2,
        DEU_pool2,
        DED_pool2,
        DMU_pool3,
        DMD_pool3,
        DEU_pool3,
        DED_pool3,
        RF,
      ];
}
