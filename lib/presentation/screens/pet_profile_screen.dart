import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app/domain/entities/pet.dart';
import '../bloc/pet_bloc.dart';
import '../bloc/pet_event.dart';
import '../bloc/pet_state.dart';
import 'recommendation_screen.dart';

class PetProfileScreen extends StatelessWidget {
  final Pet pet;

  const PetProfileScreen({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Profile")),

      body: BlocListener<PetBloc, PetState>(
        listener: (context, state) {
          /// Navigate to recommendation
          if (state is PetLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<PetBloc>(),
                  child: RecommendationScreen(),
                ),
              ),
            );
          }

          if (state is PetError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// PET DETAILS
              Text("Name: ${pet.name}", style: TextStyle(fontSize: 18)),
              Text("Species: ${pet.species}"),
              Text("Breed: ${pet.breed}"),
              Text("Age: ${pet.ageYears}y ${pet.ageMonths}m"),
              Text("Weight: ${pet.weightKg} kg"),
              Text("Activity: ${pet.activityLevel}"),
              Text("Allergies: ${pet.allergies.join(", ")}"),

              const SizedBox(height: 30),

              /// CTA BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<PetBloc>()
                        .add(FetchRecommendationEvent(pet.id));
                  },
                  child: const Text("Get Meal Plan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}