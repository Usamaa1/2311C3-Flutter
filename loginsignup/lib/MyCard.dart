import 'dart:convert';

import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.imageName,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    this.onPressed,
    required this.cartIcon,
  });

  final String imageName;
  final String productName;
  final String productDescription;
  final String productPrice;
  final Icon cartIcon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 233, 233, 233),
      elevation: 10,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.memory(base64Decode(imageName)),
              Padding(
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  child: IconButton(onPressed: onPressed, icon: cartIcon),
                ),
              ),
            ],
          ),
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
