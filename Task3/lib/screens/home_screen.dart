import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../widgets/destination_card.dart';
import '../utils/constants.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final destinations = Provider.of<DestinationProvider>(context).destinations;

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Destinations Details',    style: TextStyle(
          fontFamily: 'Nunito',
          fontSize: 20,
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle:true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.backgroundGradient,
          image: DecorationImage(
            image: AssetImage('assets/images/topographic.jpg'), // Add the topographic image
            fit: BoxFit.cover, // Ensure it covers the entire screen
            opacity: 0.5, // Make it semi-transparent
          ),
        ),
        child: ListView.builder(
          itemCount: destinations.length,
          itemBuilder: (context, index) {
            return DestinationCard(
              destination: destinations[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      destination: destinations[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}