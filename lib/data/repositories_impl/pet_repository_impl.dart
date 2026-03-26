import 'package:pet_app/data/datasources/pet_remote_datasource.dart';
import 'package:pet_app/data/models/pet_model.dart';
import 'package:pet_app/data/models/recommendation_model.dart';
import 'package:pet_app/domain/entities/pet.dart';
import 'package:pet_app/domain/entities/recommendation.dart';
import 'package:pet_app/domain/repositories/pet_repository.dart';

class PetRepositoryImpl extends PetRepository{
  final PetRemoteDataSource remoteDataSource;

  PetRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> createPet(Map<String, dynamic> data) async{
    try{
      final res = await remoteDataSource.createPet(data);
      print("API RESPONSE: ${res}");
      return res["id"];
    } catch(e){
      print("API ERROR: $e");
      throw Exception(e.toString());
    }
  }

  @override
  Future<Recommendation> getRecommendation(String id) async{
    final res = await remoteDataSource.getRecommendation(id);
    return RecommendationModel.fromJson(res);
  }

  @override
  Future<Pet> getPetById(String id) async {
    final res = await remoteDataSource.getPetById(id);
    return PetModel.fromJson(res);
  }
}