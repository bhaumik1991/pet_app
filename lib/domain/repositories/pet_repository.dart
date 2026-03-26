import 'package:pet_app/domain/entities/pet.dart';
import 'package:pet_app/domain/entities/recommendation.dart';

abstract class PetRepository{
  Future<String> createPet(Map<String, dynamic> data);
  Future<Recommendation> getRecommendation(String id);
  Future<Pet> getPetById(String id);
}