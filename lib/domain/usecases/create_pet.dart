import 'package:pet_app/domain/repositories/pet_repository.dart';

class CreatePetUseCase{
  final PetRepository petRepository;

  CreatePetUseCase(this.petRepository);

  Future<String> call(Map<String, dynamic> data){
    return petRepository.createPet(data);
  }
}