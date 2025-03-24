import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../utils/constants.dart';

class DetailsScreen extends StatefulWidget {
  final Destination destination;

  DetailsScreen({required this.destination});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Duration for one cycle of the animation
    )..repeat(); // Repeat the animation

    // Define a Tween for the horizontal movement of the text
    _animation = Tween<double>(begin: -200, end: 250).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // Smooth continuous movement
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: AppTheme.backgroundDark,
            flexibleSpace: FlexibleSpaceBar(
              title: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0), // Horizontal movement
                    child: Text(
                      widget.destination.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.neonYellow,
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                  );
                },
              ),
              background: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.neonYellow.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Image.asset(
                  widget.destination.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white, // Change the color here
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                decoration: BoxDecoration(

                  gradient: AppTheme.backgroundGradient,
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.destination.location,
                        style: TextStyle(fontSize: 18, color: AppTheme.textSecondary,
                          fontFamily: 'Nunito',
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: AppTheme.textSecondary.withOpacity(0.6), // Line color
                        thickness: 1.5, // Line thickness
                        indent: 0, // Left indent
                        endIndent: 0, // Right indent
                      ),
                      Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 20,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.neonYellow,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.destination.description,
                        style: TextStyle(fontSize: 18, color: AppTheme.textPrimary,
                        fontFamily: 'CormorantGaramond-VariableFont_wght',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.0,
                        )
                      ),
                      SizedBox(height: 30),
                      Divider(
                        color: AppTheme.textSecondary.withOpacity(0.6), // Line color
                        thickness: 1.5, // Line thickness
                        indent: 0, // Left indent
                        endIndent: 0, // Right indent
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // View on Google Maps Button
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Slightly smaller than Get Started
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppTheme.backgroundDark, // Match Get Started background
                                border: Border.all(color: AppTheme.neonYellow, width: 0.5), // Match Get Started border
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.neonYellow, // Match Get Started glow
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child:                Text(
                                'Google Map',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  fontSize: 12,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.neonYellow,
                                  shadows: [
                                    Shadow(
                                      color: AppTheme.neonYellow.withOpacity(0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Book a Trip Button
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Slightly smaller than Get Started
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppTheme.backgroundDark, // Match Get Started background
                                border: Border.all(color: AppTheme.neonYellow, width: 0.5), // Match Get Started border
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.neonYellow, // Match Get Started glow
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child:                 Text(
                                'Book Travel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Orbitron',
                                  letterSpacing: 1.8,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.neonYellow,
                                  shadows: [
                                    Shadow(
                                      color: AppTheme.neonYellow.withOpacity(0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
