import 'package:pet_app/domain/entities/pet.dart';
import 'package:pet_app/domain/repositories/pet_repository.dart';

class GetPetById {
  final PetRepository repo;

  GetPetById(this.repo);

  Future<Pet> call(String id) {
    return repo.getPetById(id);
  }
}