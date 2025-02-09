Adhicine - Medicine Management App

Adhicine is a Flutter-based medicine management app that helps users track and manage their medications efficiently. The app uses Firebase Firestore for data storage, Provider for state management, and Flutter Secure Storage for secure local storage.

🚀 Features

Add, edit, and delete medicines

Set reminders for medicine intake

Organize medicines into compartments

Search and filter medicines

Secure data storage using Flutter Secure Storage

🛠️ Tech Stack

Flutter (Dart)

Firebase Firestore (Database)

Provider (State Management)

Flutter Secure Storage (Local Storage)

📦 Installation & Setup

1️⃣ Prerequisites

Make sure you have the following installed:

Flutter: Install Flutter

Dart: Comes with Flutter SDK

Firebase CLI: Install Firebase CLI

Android Studio/Xcode (for emulators)

2️⃣ Clone the Repository

git clone https://github.com/gaurav905800/adhicine.git
cd adhicine

3️⃣ Install Dependencies

flutter pub get

4️⃣ Setup Firebase

Go to Firebase Console

Create a new project

Add an Android and iOS app

Download google-services.json (Android) and GoogleService-Info.plist (iOS)

Place them in android/app/ and ios/Runner/ respectively

Enable Firestore Database and Authentication in Firebase

5️⃣ Run the App

flutter run

To run on a specific device:

flutter run -d chrome # Web
flutter run -d android # Android Emulator
flutter run -d ios # iOS Simulator
