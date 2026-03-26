#  Pet Meal Planner (Flutter + Node.js BFF)

##  Overview

This project is a fullstack application built as part of a technical assignment. It consists of:

* **Flutter Mobile App** — Pet onboarding + meal recommendation UI
* **Node.js BFF (Backend for Frontend)** — Handles business logic and API responses

The app collects pet details and provides a **personalized meal plan recommendation**.

---

# How to Run the Node.js BFF

## Prerequisites

* Node.js (v18+ recommended)
* npm

## Steps

```bash
# Clone the repository
git clone <your-repo-url>

# Navigate to backend
cd pet-bff

# Install dependencies
npm install

# Run the server
npm run dev
```

## Server URL

```bash
http://localhost:3000
```

## Notes

* No database is used (in-memory storage)
* No environment variables required for this assignment

---

# How to Run the Flutter App

## Prerequisites

* Flutter SDK (3.x)
* Android Studio / Xcode

## Steps

```bash
# Navigate to flutter app
cd pet_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

# API Configuration (IMPORTANT)

Update base URL in your Flutter project:

### Android Emulator

```dart
http://10.0.2.2:3000
```

### iOS Simulator

```dart
http://localhost:3000
```

### Real Device

```dart
http://<YOUR_LOCAL_IP>:3000
```

---

# Architecture

## Backend (Node.js BFF)

* **Layered Architecture**

  * Routes → Controllers → Services → Models
* Business logic (recommendation engine) is isolated in the service layer
* Type-safe implementation using TypeScript
* In-memory data store for simplicity

## Frontend (Flutter)

* **Clean Architecture (simplified)**

  * Presentation (UI + BLoC)
  * Domain (UseCases)
  * Data (Repository + API)
* State management using **BLoC**
* Dio used for API communication

---

# Key Features

* Pet onboarding form (name, species, weight, activity, allergies)
* Dynamic meal recommendation based on:

  * Weight
  * Activity level
  * Allergies
* Product recommendation UI (image, price, description)
* Error handling and loading states
* Widget tests + unit tests

---

# Architectural Decisions & Trade-offs

* Chose **BFF architecture** to centralize business logic and simplify Flutter UI.
* Used **in-memory storage** instead of a database to keep the solution lightweight and focused on logic.
* Implemented **BLoC** for predictable state management and scalability.
* Kept clean architecture slightly simplified to balance clarity and development speed within time constraints.
* Did not implement authentication or persistence as they were out of scope for this assignment.

---

#  Testing

## Backend

```bash
npm test
```

* Unit tests for recommendation logic

## Flutter

```bash
flutter test
```

* Widget tests for UI and interactions

---

# Future Improvements

* Add database (MongoDB / PostgreSQL)
* Implement authentication
* Improve UI/UX with animations
* Add caching & offline support
* Add CI/CD pipeline

---

# Author

Arunava Bhaumik
