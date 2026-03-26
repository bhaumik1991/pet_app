import 'package:pet_app/domain/entities/pet.dart';

abstract class PetEvent {}
class FetchRecommendationEvent extends PetEvent {
  final String id;

  FetchRecommendationEvent(this.id);
}
class SubmitPetEvent extends PetEvent {
  final Map<String, dynamic> data;

  SubmitPetEvent(this.data);
}