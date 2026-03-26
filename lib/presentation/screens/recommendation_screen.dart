import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pet_bloc.dart';
import '../bloc/pet_state.dart';

class RecommendationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meal Plan")),

      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {

          if (state is PetLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PetLoaded) {
            final rec = state.recommendation;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rec.planName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  Text("Calories: ${rec.dailyKcal} kcal/day"),

                  Text("Proteins: ${rec.proteins.join(", ")}"),

                  Text("Portion: ${rec.dailyPortionGrams} g/day"),

                  const SizedBox(height: 20),

                  const Text(
                    "Recommended Products",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...rec.products.map((p) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(p.imageUrl, width: 60),
                        title: Text(p.name),
                        subtitle: Text(p.description),
                        trailing: Text("AED ${p.priceAed}"),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 20),

                  /// CTA
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("Subscription Started"),
                        ),
                      );
                    },
                    child: Center(child: const Text("Start My Subscription")),
                  ),
                ],
              ),
            );
          }

          if (state is PetError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}