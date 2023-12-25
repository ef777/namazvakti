import 'package:flutter/material.dart';

class PrayerTimeScreen extends StatelessWidget {
  var notificationData;
  PrayerTimeScreen({Key? key, this.notificationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('namaz Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Namaz vakitleri.', // Updated message
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
           
          ],
        ),
      ),
    );
  }
}
