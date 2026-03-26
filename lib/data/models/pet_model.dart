import 'package:pet_app/domain/entities/pet.dart';

class PetModel extends Pet {
  const PetModel({
    required super.id,
    required super.name,
    required super.species,
    required super.breed,
    required super.ageYears,
    required super.ageMonths,
    required super.weightKg,
    required super.activityLevel,
    required super.allergies,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      breed: json['breed'],
      ageYears: json['ageYears'],
      ageMonths: json['ageMonths'],
      weightKg: (json['weightKg'] as num).toDouble(),
      activityLevel: json['activityLevel'],
      allergies: List<String>.from(json['allergies']),
    );
  }
}