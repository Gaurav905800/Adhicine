import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class MedicineModel {
  String id;
  String name;
  String type;
  int quantity;
  int totalCount;
  String dosage;
  String frequency;
  String timesADay;
  int compartment;
  String color;
  Timestamp startDate;
  Timestamp endDate;

  MedicineModel({
    String? id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.totalCount,
    required this.dosage,
    required this.frequency,
    required this.timesADay,
    required this.compartment,
    required this.color,
    required this.startDate,
    required this.endDate,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'totalCount': totalCount,
      'dosage': dosage,
      'frequency': frequency,
      'timesADay': timesADay,
      'compartment': compartment,
      'color': color,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['id'] ?? const Uuid().v4(),
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      quantity: map['quantity'] ?? 0,
      totalCount: map['totalCount'] ?? 0,
      dosage: map['dosage'] ?? '1 Pill',
      frequency: map['frequency'] ?? 'Everyday',
      timesADay: map['timesADay'] ?? 'Three Time',
      compartment: map['compartment'] ?? 1,
      color: map['color'] ?? 'blue',
      startDate: (map['startDate'] as Timestamp?) ?? Timestamp.now(),
      endDate: (map['endDate'] as Timestamp?) ?? Timestamp.now(),
    );
  }
}
