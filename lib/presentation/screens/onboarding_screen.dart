import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pet_bloc.dart';
import '../bloc/pet_event.dart';
import '../bloc/pet_state.dart';
import 'pet_profile_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final weightCtrl = TextEditingController();

  String species = "dog";
  String breed = "Labrador Retriever";
  String activity = "moderate";
  double age = 2.0;

  List<String> allergies = [];

  final Map<String, List<String>> breeds = {
    "dog": [
      "Labrador Retriever",
      "Beagle",
      "Pug",
      "German Shepherd",
      "Golden Retriever",
      "Bulldog",
      "Husky",
      "Shih Tzu"
    ],
    "cat": [
      "Persian",
      "Siamese",
      "Maine Coon",
      "Bengal",
      "Sphynx",
      "Ragdoll",
      "British Shorthair",
      "Abyssinian"
    ]
  };

  final allergyOptions = [
    "chicken",
    "beef",
    "fish",
    "grain",
    "dairy"
  ];

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<PetBloc>().add(
      SubmitPetEvent({
        "name": nameCtrl.text.trim(),
        "species": species,
        "breed": breed,
        "ageYears": age.floor(),
        "ageMonths": ((age - age.floor()) * 12).round(),
        "weightKg": double.parse(weightCtrl.text),
        "activityLevel": activity,
        "allergies": allergies.isEmpty ? ["none"] : allergies,
      }),
    );
  }

  Widget buildAllergyChip(String label) {
    final selected = allergies.contains(label);

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() {
          selected ? allergies.remove(label) : allergies.add(label);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pet Profile")),

      body: BlocListener<PetBloc, PetState>(
        listener: (context, state) {
          /// Navigate when profile is loaded
          if (state is PetProfileLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PetProfileScreen(pet: state.pet),
              ),
            );
          }

          /// Error
          if (state is PetError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        child: BlocBuilder<PetBloc, PetState>(
          builder: (context, state) {
            final isLoading = state is PetLoading;

            return Stack(
              children: [
                Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      /// NAME
                      TextFormField(
                        controller: nameCtrl,
                        decoration:
                        const InputDecoration(labelText: "Pet Name"),
                        validator: (v) =>
                        v == null || v.isEmpty ? "Required" : null,
                      ),

                      const SizedBox(height: 12),

                      /// SPECIES
                      DropdownButtonFormField<String>(
                        value: species,
                        decoration:
                        const InputDecoration(labelText: "Species"),
                        items: ["dog", "cat"]
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toUpperCase()),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            species = value!;
                            breed = breeds[species]!.first;
                          });
                        },
                      ),

                      const SizedBox(height: 12),

                      /// BREED
                      DropdownButtonFormField<String>(
                        value: breed,
                        decoration:
                        const InputDecoration(labelText: "Breed"),
                        items: breeds[species]!
                            .map((b) => DropdownMenuItem(
                          value: b,
                          child: Text(b),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            breed = value!;
                          });
                        },
                      ),

                      const SizedBox(height: 12),

                      /// AGE
                      Text("Age: ${age.toStringAsFixed(1)} years"),
                      Slider(
                        value: age,
                        min: 0,
                        max: 15,
                        divisions: 30,
                        onChanged: (v) => setState(() => age = v),
                      ),

                      const SizedBox(height: 12),

                      /// WEIGHT
                      TextFormField(
                        controller: weightCtrl,
                        keyboardType: TextInputType.number,
                        decoration:
                        const InputDecoration(labelText: "Weight (kg)"),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
                          final val = double.tryParse(v);
                          if (val == null || val <= 0) {
                            return "Invalid weight";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      /// ACTIVITY
                      DropdownButtonFormField<String>(
                        value: activity,
                        decoration:
                        const InputDecoration(labelText: "Activity Level"),
                        items: ["low", "moderate", "high"]
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toUpperCase()),
                        ))
                            .toList(),
                        onChanged: (v) => setState(() => activity = v!),
                      ),

                      const SizedBox(height: 16),

                      /// ALLERGIES
                      const Text("Allergies / Intolerances"),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: allergyOptions
                            .map(buildAllergyChip)
                            .toList(),
                      ),

                      const SizedBox(height: 20),

                      /// SUBMIT
                      ElevatedButton(
                        onPressed: isLoading ? null : submit,
                        child: const Text("Get Pet Profile"),
                      ),
                    ],
                  ),
                ),

                /// LOADING OVERLAY
                if (isLoading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}