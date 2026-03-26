import 'package:pet_app/domain/entities/recommendation.dart';
import 'package:pet_app/domain/repositories/pet_repository.dart';

class GetRecommendationUseCase{
  final PetRepository petRepository;

  GetRecommendationUseCase(this.petRepository);

  Future<Recommendation> call(String id){
    return petRepository.getRecommendation(id);
  }
}