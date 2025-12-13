import 'dart:convert';

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.imageName,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
  });

  final String imageName;
  final String productName;
  final String productDescription;
  final String productPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 233, 233, 233),
      elevation: 10,
      child: Column(
        children: [
          Image.memory(base64Decode(imageName)),
          SizedBox(height: 6),
          Text(productName, style: TextStyle(fontSize: 18)),
          SizedBox(height: 6),
          Text(productPrice),
          SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(productDescription),
          ),
          // SizedBox(height: 6),
        ],
      ),
    );
  }
}
