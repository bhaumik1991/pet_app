import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/data/datasources/pet_remote_datasource.dart';
import 'package:pet_app/domain/usecases/get_pet.dart';
import 'package:pet_app/presentation/screens/onboarding_screen.dart';
import 'package:pet_app/presentation/screens/recommendation_screen.dart';
import 'data/repositories_impl/pet_repository_impl.dart';
import 'domain/usecases/create_pet.dart';
import 'domain/usecases/get_recommendation.dart';
import 'presentation/bloc/pet_bloc.dart';

void main() {
  final remote = PetRemoteDataSource();
  final repo = PetRepositoryImpl(remote);

  final createPet = CreatePetUseCase(repo);
  final getRecommendation = GetRecommendationUseCase(repo);
  final getPetById = GetPetById(repo);

  runApp(MyApp(
    createPet: createPet,
    getRecommendation: getRecommendation,
    getPetById: getPetById,
  ));
}

class MyApp extends StatelessWidget {
  final CreatePetUseCase createPet;
  final GetRecommendationUseCase getRecommendation;
  final GetPetById getPetById;

  const MyApp({required this.createPet, required this.getRecommendation, required this.getPetById});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PetBloc(createPet, getRecommendation, getPetById),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Pet Meal Planner",
          initialRoute: "/",
          routes: {
            "/": (context) => OnboardingScreen(),
            "/recommendation": (context) => RecommendationScreen(),
          },
        ),
    );
  }
}