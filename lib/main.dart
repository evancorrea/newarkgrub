import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // If .env doesn't exist, that's okay - app will work without API key
    print('No .env file found, running without Google Maps API key');
  }

  runApp(const NewarkGrubApp());
}

class NewarkGrubApp extends StatelessWidget {
  const NewarkGrubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewarkGrub - Food Trucks in Newark, NJ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3498db),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
