import 'package:dio/dio.dart';
import 'package:pet_app/core/config/config.dart';

class PetRemoteDataSource{

  final Dio dio = Dio(BaseOptions(baseUrl: Config.baseUrl));

  Future<Map<String, dynamic>> createPet(Map<String, dynamic> data) async {
    final res = await dio.post("/pets", data: data);
    print("Response ${res.data}");
    return res.data;
  }

  Future<Map<String, dynamic>> getRecommendation(String id) async {
    final res = await dio.get("/pets/$id/recommendation");
    return res.data;
  }

  Future<Map<String, dynamic>> getPetById(String id) async {
    final res = await dio.get("/pets/$id");
    return res.data;
  }
}