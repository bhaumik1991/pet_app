import 'package:equatable/equatable.dart';
import 'package:pet_app/domain/entities/product.dart';

class Recommendation extends Equatable{
  final String planName;
  final int dailyKcal;
  final int dailyPortionGrams;
  final List<String> proteins;
  final List<Product> products;

  const Recommendation({
    required this.planName,
    required this.dailyKcal,
    required this.dailyPortionGrams,
    required this.proteins,
    required this.products,
  });

  @override
  List<Object?> get props => [planName];
}