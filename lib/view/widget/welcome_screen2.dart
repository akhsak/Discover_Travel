import 'package:flutter/material.dart';
import 'package:travel/view/widget/welcome_screen3.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash1.img.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.50),
              child: Container(
                height: screenHeight * 0.15,
                width: screenWidth * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/icon_white.png'))),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              height: screenHeight * 0.3,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.4,
                        top: screenHeight * 0.01),
                    child: Text(
                      'Visit tourist \nattractions',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: screenHeight * 0.03,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenHeight * 0.02),
                    child: Text(
                      'Find thousands of tourist destinations ready for you to visit',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize:
                              Size(screenWidth * 0.75, screenHeight * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen3()));
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
          ],
        ),
      ),
    );
  }
}
