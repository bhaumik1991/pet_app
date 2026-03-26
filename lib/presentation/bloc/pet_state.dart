import 'package:pet_app/domain/entities/pet.dart';
import 'package:pet_app/domain/entities/recommendation.dart';

abstract class PetState {}

class PetInitial extends PetState{}

class PetLoading extends PetState{}

class PetLoaded extends PetState{
  final Recommendation recommendation;
  PetLoaded(this.recommendation);
}

class PetProfileLoaded extends PetState {
  final Pet pet;

  PetProfileLoaded(this.pet);
}

class PetError extends PetState{
  final String message;
  PetError(this.message);
}