# NewarkGrub

A Flutter/Dart application for discovering and managing food trucks in Newark, NJ. Features Google Maps integration to visualize food truck locations. Runs on Android, iOS, and Web platforms.

## Features

- **View** all food trucks with details (cuisine, rating, hours, location)
- **Add** new food trucks to the directory
- **Edit** existing food truck information
- **Delete** food trucks from the listing
- **Interactive Map** showing food truck locations with clickable markers
- **Responsive Design** that works on Android, iOS, and Web platforms

## Tech Stack

- Flutter 3.x
- Dart 3.x
- google_maps_flutter (Google Maps integration for mobile)
- google_maps_flutter_web (Google Maps integration for web)
- flutter_dotenv (environment variables)
- Provider (state management)

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / Xcode (for mobile development)
- Chrome browser (for web development)
- A physical device or emulator/simulator (for mobile)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/newarkgrub.git
cd newarkgrub
```

2. Install dependencies:
```bash
flutter pub get
```

3. **Create the `.env` file (REQUIRED):**
   ```bash
   cp .env.example .env
   ```

   The app requires a `.env` file to build, even without a Google Maps API key. The default placeholder values will work fine - the app will display a list view instead of the map.

4. (Optional) Add Google Maps API Key:
   - Edit the `.env` file and add your API key:
   ```
   GOOGLE_MAPS_API_KEY=your_actual_api_key_here
   ```
   - Get an API key from [Google Cloud Console](https://console.cloud.google.com/google/maps-apis)
   - Enable the following APIs:
     - **Maps SDK for Android**
     - **Maps SDK for iOS**
     - **Maps JavaScript API** (for web support)

5. Run the app:
```bash
flutter run
```

   Or run on a specific platform:
```bash
flutter run -d android    # Android device/emulator
flutter run -d ios        # iOS device/simulator
flutter run -d chrome     # Chrome browser (web)
```

## Usage

### Viewing Food Trucks
- Browse the list of food trucks on the left panel
- Click on any truck card to highlight its location on the map
- View details including cuisine type, rating, hours, and contact information

### Adding a Food Truck
- Click the "+ Add New" button
- Fill in the required information
- Click "Add Food Truck" to save

### Editing a Food Truck
- Click the "Edit" button on any food truck card
- Modify the information as needed
- Click "Update Food Truck" to save changes

### Deleting a Food Truck
- Click the "Delete" button on any food truck card
- Confirm the deletion in the popup dialog

### Map Interaction
- Click on map markers to view food truck information
- Selected trucks are highlighted with an orange marker
- The map automatically centers on the selected truck

## Project Structure

```
newarkgrub/
├── lib/
│   ├── models/
│   │   └── food_truck.dart      # FoodTruck and Location models
│   ├── data/
│   │   └── food_trucks.dart     # Initial data for demo
│   ├── widgets/
│   │   ├── header.dart          # App header widget
│   │   ├── food_truck_list.dart # List of all food trucks
│   │   ├── food_truck_card.dart # Individual truck card
│   │   ├── food_truck_form.dart # Add/Edit form
│   │   └── map_view.dart        # Google Maps integration
│   ├── screens/
│   │   └── home_screen.dart     # Main home screen
│   └── main.dart                # App entry point
├── android/                     # Android-specific files
├── ios/                         # iOS-specific files
├── web/                         # Web-specific files
├── pubspec.yaml                 # Flutter dependencies
└── .env                         # Environment variables
```

## Development

### Available Commands

- `flutter run` - Run the app in debug mode
- `flutter run -d chrome` - Run in Chrome browser
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter build web` - Build web app
- `flutter test` - Run tests
- `flutter analyze` - Analyze code for issues

### Note on Google Maps

The app works without a Google Maps API key - it will display a placeholder showing food truck locations. For full map functionality, add your API key to the `.env` file.

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```
The built web app will be in the `build/web` directory and can be deployed to any static hosting service.

## Demo Data

The app comes with 6 sample food trucks located around Newark, NJ:
- Newark Taco Express (Mexican)
- Brick City BBQ (BBQ)
- Jersey Gyro King (Mediterranean)
- Aloha Poke Bowl (Hawaiian)
- Sweet Street Desserts (Desserts)
- Philly Cheesesteak Co (American)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
