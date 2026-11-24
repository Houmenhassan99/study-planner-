Group 3
My study planner
Group members:
_24429/2024
_24798/2024
_26465/2024
_26334/2024
_25996/2024

# MY STUDY PLANNER

## 1. Project Overview

My Study Planner is a mobile application developed using Flutter and Dart for the Mobile App Development course at the University of Lay Adventists of Kigali (UNILAK).

The application helps students organize their study activities by creating study goals, managing study hours, tracking completed goals, and monitoring their study progress.

## 2. Project Objectives

The main objectives of this project are:

- To help students organize their study goals.
- To allow students to manage their planned study hours.
- To track completed and remaining study goals.
- To calculate total study hours.
- To practise mobile application development using Flutter and Dart.
- To learn how to store application data using a local SQLite database.

## 3. Main Features

- Add new study goals.
- Display study goals in a list.
- Mark study goals as completed.
- Delete study goals.
- Calculate total study hours.
- Display completed goals.
- Display remaining goals.
- Validate user input when adding goals.
- Store study goals locally using SQLite (Phase 5).

## 4. Technologies Used

- **Flutter:** Framework used to develop the mobile application.
- **Dart:** Programming language used to write the application.
- **SQLite:** Local database used to store study goals.
- **sqflite:** Flutter package for SQLite database operations.
- **path:** Package used to create the database file path.

## 5. Project Development Phases

### Phase 1: Static Screen
Created the initial user interface with an AppBar, study goal cards, a heading, and a FloatingActionButton.

### Phase 2: Working List
Implemented a dynamic list that allows users to add, complete, and delete study goals using setState().

### Phase 3: Statistics and Cards
Added statistics showing total study hours, completed goals, and remaining goals using reusable StatCard widgets.

### Phase 4: Second Screen
Implemented a separate screen for adding study goals, including input validation and navigation between screens.

### Phase 5: Database Persistence
Implemented SQLite database storage to save study goals and maintain them even after closing and reopening the application.

## 6. Project Structure

```text
study_planner/
│
├── lib/
│   ├── main.dart
│   └── database_helper.dart
│
├── pubspec.yaml
├── README.md
└── android/
└── ios/
```

## 7. Installation and Running the Application

### Requirements
- Flutter SDK
- Dart SDK
- Visual Studio Code or Android Studio
- Android Emulator or physical device

### Steps

1. Open the project in Visual Studio Code or Android Studio.
2. Open the terminal.
3. Install the required dependencies:

```bash
flutter pub get
```

4. Run the application:

```bash
flutter run
```

## 8. Expected Results

The application allows students to manage their study goals efficiently. Users can add new subjects, assign study hours, mark goals as completed, delete goals, and view updated statistics.

In the final phase, study goals are stored in a local SQLite database so that the information remains available after restarting the application.

## 9. Course Information

**Project Name:** My Study Planner

**Course:** Mobile App Development (Dart & Flutter)

**Institution:** University of Lay Adventists of Kigali (UNILAK)

**Project Type:** Individual Final Project

**Programming Language:** Dart

**Framework:** Flutter

## 10. Conclusion

My Study Planner provides a simple way for students to organize and monitor their study activities. Through this project, practical skills in Dart programming, Flutter widgets, state management, navigation, form validation, and SQLite database management are developed.