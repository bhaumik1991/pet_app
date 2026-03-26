import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pet_app/presentation/bloc/pet_bloc.dart';
import 'package:pet_app/presentation/bloc/pet_event.dart';
import 'package:pet_app/presentation/bloc/pet_state.dart';
import 'package:pet_app/presentation/screens/onboarding_screen.dart';

class MockPetBloc extends Mock implements PetBloc {}

class FakePetEvent extends Fake implements PetEvent {}
class FakePetState extends Fake implements PetState {}

void main() {
  late MockPetBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakePetEvent());
    registerFallbackValue(FakePetState());
  });

  setUp(() {
    mockBloc = MockPetBloc();

    when(() => mockBloc.state).thenReturn(PetInitial());

    when(() => mockBloc.stream).thenAnswer(
          (_) => const Stream<PetState>.empty(),
    );
  });

  Widget createWidget() {
    return MaterialApp(
      home: BlocProvider<PetBloc>.value(
        value: mockBloc,
        child: OnboardingScreen(),
      ),
    );
  }

  // TEST 1: UI renders
  testWidgets("should render onboarding screen", (tester) async {
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
            (widget) => widget is TextField || widget is TextFormField,
      ),
      findsWidgets,
    );

    expect(find.text("Get Pet Profile"), findsOneWidget);
  });

  // ✅ TEST 2: Button triggers event
  testWidgets("should call bloc on button tap", (tester) async {
    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    final textField = find.byWidgetPredicate(
          (widget) => widget is TextField || widget is TextFormField,
    );

    await tester.enterText(textField.first, "Bruno");

    final button = find.byType(ElevatedButton);

    expect(button, findsOneWidget); // sanity check

    await tester.tap(button);
    await tester.pumpAndSettle();

    verify(() => mockBloc.add(any())).called(greaterThan(0));
  });
}