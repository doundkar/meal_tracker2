# 🥗 Meal Tracker App

A simple and clean Flutter mobile application to track your daily meals. Users can log meals with name, type, date, and image, and view their meal history grouped by date. Built using **Riverpod**, **Clean Architecture**, and **SQLite**.

---

## 📱 Features

- Add meals with:
  - Meal name
  - Meal type (Breakfast, Lunch, Dinner, Snack)
  - Date picker
  - Photo (from gallery)
- View meal history grouped by date
- Thumbnail images of meals
- Search by meal name
- Pull-to-refresh
- Local storage using SQLite
- Clean architecture with domain/data/presentation layers

---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/doundkar/meal_tracker2
cd meal_tracker2

```
### 2. Install dependencies
- flutter pub get 

### 3. Run the app
- flutter run

### 4. Dependencies
- Flutter (3.29.2)

- flutter_riverpod

- sqflite

- path_provider

- image_picker

You can add meals manually using the form in the app. For testing, try different dates and names to see the grouping and search in action.
