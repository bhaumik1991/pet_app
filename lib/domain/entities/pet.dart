import 'package:equatable/equatable.dart';

class Pet extends Equatable{
  final String id;
  final String name;
  final String species;
  final String breed;
  final int ageYears;
  final int ageMonths;
  final double weightKg;
  final String activityLevel;
  final List<String> allergies;

  const Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.ageYears,
    required this.ageMonths,
    required this.weightKg,
    required this.activityLevel,
    required this.allergies
  });

  @override
  List<Object?> get props => [name, species];
}