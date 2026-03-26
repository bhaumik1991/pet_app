import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/domain/usecases/create_pet.dart';
import 'package:pet_app/domain/usecases/get_pet.dart';
import 'package:pet_app/domain/usecases/get_recommendation.dart';
import 'package:pet_app/presentation/bloc/pet_event.dart';
import 'package:pet_app/presentation/bloc/pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final CreatePetUseCase createPet;
  final GetRecommendationUseCase getRecommendation;
  final GetPetById getPetById;

  PetBloc(this.createPet, this.getRecommendation, this.getPetById) : super(PetInitial()){

    on<SubmitPetEvent>((event, emit) async{
      emit(PetLoading());
      try{
        final id = await createPet(event.data);
        final pet = await getPetById(id);
        emit(PetProfileLoaded(pet));
        final rec = await getRecommendation(id);
        print("SUCCESS: $rec");

        emit(PetLoaded(rec));
      } catch(e){
        print("BLOC ERROR: $e");
        emit(PetError("Something went wrong"));
      }
    });

    on<FetchRecommendationEvent>((event, emit) async {
      emit(PetLoading());

      try {
        final rec = await getRecommendation(event.id);
        emit(PetLoaded(rec));
      } catch (e) {
        emit(PetError("Failed to fetch recommendation"));
      }
    });
  }
}