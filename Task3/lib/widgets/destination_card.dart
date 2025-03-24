import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../utils/constants.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;

  DestinationCard({required this.destination, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        color: AppTheme.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppTheme.neonYellow, width: 1),
        ),
        child: Column(

          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.neonYellow .withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  destination.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    destination.name,
                    style: TextStyle(
                      fontFamily:'Nunito',
                      letterSpacing:2.5,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.neonYellow,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    destination.location,
                    style: TextStyle(fontSize: 15, color: AppTheme.textSecondary,
                      fontFamily: 'Orbitron',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,

                    ),

                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}