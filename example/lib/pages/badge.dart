import 'package:flutter/material.dart';

import 'package:saturn/saturn.dart';

class BadgePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('badge'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            STBadge(
              dot: true,
            ),
            SizedBox(height: 30),
            STBadge(
              dot: true,
              child: Text('文字'),
            ),
            SizedBox(height: 30),
            STBadge(
              child: Icon(Icons.book),
              maxNumber: 99,
              value: '100',
              backgroundColor: Colors.purple,
            ),
            SizedBox(height: 30),
            STBadge(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Icon',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              maxNumber: 12,
              value: '30',
            ),
            SizedBox(height: 30),
            STBadge(
              value: 'Price',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
