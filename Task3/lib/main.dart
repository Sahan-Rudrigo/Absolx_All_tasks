import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/screens/welcome_screen.dart';
import 'models/destination.dart';
import 'screens/home_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DestinationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Destinations',
      theme: ThemeData(
        primaryColor: AppTheme.neonYellow,
        scaffoldBackgroundColor: AppTheme.backgroundDark,
        textTheme: TextTheme(
          titleLarge: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: AppTheme.textPrimary),
          bodyMedium: TextStyle(color: AppTheme.textSecondary),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.backgroundDark,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppTheme.neonYellow,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

class DestinationProvider with ChangeNotifier {
  final List<Destination> _destinations = [
    Destination(
      name: 'Paris',
      location: 'France',
      imageUrl: 'assets/images/paris.jpg',
      description: 'Parsi is an ancient city in Iran, historically associated with Persian culture and the Zoroastrian community. It played a significant role in the development of Persian civilization, serving as a center for trade, art, and religious practices. The city reflects Iran’s rich architectural heritage, with historical sites and cultural landmarks that showcase its deep-rooted history. Today, it remains an important symbol of Persian identity and heritage.',
    ),
    Destination(
      name: 'Tokyo',
      location: 'Japan',
      imageUrl: 'assets/images/tokyo.jpg',
      description: 'Tokyo is the capital of Japan and one of the most vibrant cities in the world. It is a global center for technology, finance, and culture, blending ultramodern skyscrapers with historic temples. Known for its bustling streets, advanced transportation systems, and diverse cuisine, Tokyo offers a unique mix of tradition and innovation. Famous attractions include Shibuya Crossing, the historic Asakusa district, and the iconic Tokyo Tower.',
    ),
    Destination(
      name: 'New York',
      location: 'USA',
      imageUrl: 'assets/images/newyork.jpg',
      description: 'New York City is one of the most influential cities in the world, known for its towering skyline, cultural diversity, and economic power. As the financial capital of the U.S., it is home to Wall Street, Broadway, and world-famous landmarks like Times Square, the Statue of Liberty, and Central Park. NYC is a melting pot of cultures, making it a hub for arts, fashion, and entertainment, attracting millions of visitors every year.',
    ),
  ];

  List<Destination> get destinations => _destinations;
}