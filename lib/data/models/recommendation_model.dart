import 'package:pet_app/data/models/product_model.dart';
import 'package:pet_app/domain/entities/recommendation.dart';


class RecommendationModel extends Recommendation{
  const RecommendationModel({
    required super.planName,
    required super.dailyKcal,
    required super.dailyPortionGrams,
    required super.proteins,
    required super.products,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json){
    return RecommendationModel(
        planName: json["planName"],
        dailyKcal: json["dailyKcal"],
        dailyPortionGrams: json["dailyPortionGrams"],
        proteins: List<String>.from(json["recommendedProteins"]),
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }
}