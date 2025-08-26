import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Title
            Text(
              'S 500 Sedan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/car.png",
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[100],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'S 500 Sedan',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 32),

            // Car Specifications
            Row(
              children: [
                Expanded(child: _buildCarSpec('Automatic')),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(horizontal: 24),
                ),
                Expanded(child: _buildCarSpec('5 seats')),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(horizontal: 24),
                ),
                Expanded(child: _buildCarSpec('Diesel')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarSpec(String spec) {
    return Center(
      child: Text(
        spec,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Alternative version with a different car image
class CarCardAlternative extends StatelessWidget {
  const CarCardAlternative({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Car Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Title
              Text(
                'S 500 Sedan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 24),

              // Car Image
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[50],
                ),
                child: Center(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1502877338535-766e1452684a?w=400&h=200&fit=crop&crop=center',
                    height: 120,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // SVG-like car illustration as fallback
                      return SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: CustomPaint(painter: CarPainter()),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 32),

              // Car Specifications
              Row(
                children: [
                  Expanded(child: _buildCarSpec('Automatic')),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(horizontal: 24),
                  ),
                  Expanded(child: _buildCarSpec('5 seats')),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[200],
                    margin: EdgeInsets.symmetric(horizontal: 24),
                  ),
                  Expanded(child: _buildCarSpec('Diesel')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarSpec(String spec) {
    return Center(
      child: Text(
        spec,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// Custom Car Painter for fallback illustration
class CarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Car body
    final Rect carBody = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: size.width * 0.8,
      height: size.height * 0.4,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(carBody, Radius.circular(8)),
      paint,
    );

    // Car roof
    final Rect carRoof = Rect.fromCenter(
      center: Offset(centerX, centerY - size.height * 0.15),
      width: size.width * 0.5,
      height: size.height * 0.25,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(carRoof, Radius.circular(6)),
      paint,
    );

    // Wheels
    final wheelPaint = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(centerX - size.width * 0.25, centerY + size.height * 0.15),
      size.height * 0.08,
      wheelPaint,
    );

    canvas.drawCircle(
      Offset(centerX + size.width * 0.25, centerY + size.height * 0.15),
      size.height * 0.08,
      wheelPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
